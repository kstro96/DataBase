package splitpay;

import java.awt.Color;
import java.util.List;
import java.util.Vector;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;

import Controladores.CuentaJpaController;
import Controladores.GrupoJpaController;
import java.math.BigDecimal;
import javax.swing.JLabel;
import java.awt.Font;
import javax.swing.SwingConstants;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

public class JPIformeBills extends JPanel {
    private GUIPrincipal principal;
    private PMenu menu;
    private JScrollPane scrollPane;
    private JTable tablaBill;
    private Vector columnSer = new Vector();
    private Vector rowDataSer;
    private Vector columSerV;

    /**
     * Create the panel.
     */
    public JPIformeBills(GUIPrincipal principal) {
        this.principal = principal;
        this.menu = menu;
			
        setBackground(Color.WHITE);
	setLayout(null);
		
	JPanel panel = new JPanel();
	panel.setBackground(Color.WHITE);
	panel.setBounds(10, 0,790, 460);
	add(panel);
	panel.setLayout(null);
		
	scrollPane = new JScrollPane();
	scrollPane.setBounds(65, 91, 625, 199);
	panel.add(scrollPane);
		
	tablaBill = getTableBill();
	scrollPane.setViewportView(tablaBill);
	
	JLabel lblNewLabel = new JLabel("Reporte cuentas por grupo");
	lblNewLabel.setHorizontalAlignment(SwingConstants.CENTER);
	lblNewLabel.setFont(new Font("Tahoma", Font.BOLD, 21));
	lblNewLabel.setBounds(0, 26, 790, 42);
	panel.add(lblNewLabel);
	
	JButton btnVolverAInicio = new JButton("Volver a inicio");
	btnVolverAInicio.addActionListener(new ActionListener() {
		public void actionPerformed(ActionEvent e) {
			principal.pasarInicio();
		}
	});
	btnVolverAInicio.setBounds(266, 317, 205, 64);
	panel.add(btnVolverAInicio);
	
	mostrarDatos();
    }

    public JTable getTableBill() {
	if (tablaBill == null) {
            EntityManagerFactory emf = Persistence.createEntityManagerFactory("SplitPayPU");
            GrupoJpaController controGrupo = new GrupoJpaController(emf);
            List<String> todosGrupos = controGrupo.listaNombre();
            columnSer.add("Anio-mes del Bil");
            for( String grupo : todosGrupos )
                columnSer.add(grupo);
            columnSer.add("Total");
            columSerV = new Vector(this.columnSer);
            rowDataSer = new Vector();
            tablaBill = new JTable(this.rowDataSer, columSerV);
            scrollPane.setViewportView(tablaBill);
            emf.close();
	}
	return tablaBill;
    }
	
    public void mostrarDatos()
    {
        System.out.println("SERVICIOS");		
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("SplitPayPU");		
        CuentaJpaController contro = new CuentaJpaController(emf);	
        GrupoJpaController controG = new GrupoJpaController(emf);
        System.out.println("ENTRO GET SERV---------------------------");
        List<String> fechas = contro.fechas();
        this.rowDataSer = new Vector(); // datos de toda la tabla
        int totalFila = 0;
        for(String fecha : fechas)
        {
            Vector fila = new Vector();
            int totalColumna = 0;
            fila.add(fecha);
            for(BigDecimal grupo : controG.listaID())
            {
                int numBill = contro.numBillsPorFecha(grupo.intValue(), fecha);
                if( numBill != -1 )
                {
                    fila.add(numBill);
                    totalColumna+=numBill;
                } else {
                    fila.add(0);
                }
            }
            fila.add(totalColumna);
            totalFila += totalColumna;
            this.rowDataSer.add(fila);
            System.out.println(fila.toString());
        }
        Vector fila = new Vector();
        fila.add("Total");
        for(BigDecimal grupo : controG.listaID())
        {
            int numBill = contro.totalPorGrupo(grupo.intValue());
            if( numBill != -1 )
            {
                fila.add(numBill);
            } else {
                fila.add(0);
            }
        }
        fila.add(totalFila);
        this.rowDataSer.add(fila);
        System.out.println(fila.toString());
        tablaBill = new JTable(this.rowDataSer, this.columSerV);
        scrollPane.setViewportView(tablaBill);// refresca el JTable
        emf.close();
    }
}
