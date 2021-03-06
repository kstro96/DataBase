package splitpay;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTable;

import java.awt.Color;

import javax.swing.JLabel;

import java.awt.Font;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.StringTokenizer;
import java.util.Vector;

import javax.swing.JScrollPane;
import javax.swing.JButton;
import javax.swing.table.TableModel;

import Controladores.CuentaJpaController;
import Controladores.GrupoJpaController;
import Controladores.UsuarioJpaController;
import Negocio.Grupo;

import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;



public class JPGruposActuales extends JPanel {
	private GUIPrincipal principal;
	private PMenu menu;
	private String[] columnSer = { "Nombre", "Balance" };
	private Vector rowDataSer;
	private Vector columSerV;
	private JTable tablaGrupos;
	private JScrollPane scrollPane;
	private JLabel label_s;
	private List<Integer> id_grupos =new ArrayList<Integer>();

	/**
	 * Create the panel.
	 */
	public JPGruposActuales(GUIPrincipal principal, PMenu menu) {
		this.principal = principal;
		this.menu = menu;
	
		
		
		setBackground(Color.WHITE);
		setLayout(null);
		
		JPanel panel = new JPanel();
		panel.setBackground(Color.WHITE);
		panel.setBounds(10, 0,790, 460);
		add(panel);
		panel.setLayout(null);
		
		JLabel lblGruposActuales = new JLabel("Grupos Actuales");
		lblGruposActuales.setFont(new Font("Tahoma", Font.BOLD, 18));
		lblGruposActuales.setBounds(65, 29, 354, 32);
		panel.add(lblGruposActuales);
		
		scrollPane = new JScrollPane();
		scrollPane.setBounds(65, 91, 625, 199);
		panel.add(scrollPane);
		
		tablaGrupos = getTableG();
		scrollPane.setViewportView(tablaGrupos);
		
		JButton btnNewButton = new JButton("Seleccionar Grupo");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				seleccionarG();
			}
		});
		btnNewButton.setBounds(542, 363, 148, 45);
		panel.add(btnNewButton);
		mostrarDatos();
		
		label_s = new JLabel("seleccione");
		label_s.setBounds(89, 363, 153, 25);
		panel.add(label_s);

	}
	public JTable getTableG() {
		System.out.println("ENTRO GET SERV");
		if (tablaGrupos == null) {
			columSerV = new Vector(Arrays.asList(this.columnSer));
			rowDataSer = new Vector();
			tablaGrupos = new JTable(this.rowDataSer, columSerV);
			scrollPane.setViewportView(tablaGrupos);

		}

		return tablaGrupos;
	}
	
public JTable mostrarDatos() {
		
		//datosDefectos(empresa);
		System.out.println("SERVICIOS");
		
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("SplitPayPU");
		
		UsuarioJpaController contro = new UsuarioJpaController(emf);
		
		List<String> grupos = contro.RealizarBalanceGruposdeUsuario(principal.userActual.getId());
		this.rowDataSer = new Vector(); // datos de toda la tabla
		
		 
		/*for(int i=0;i<15;i++)
		{
			Vector fila = new Vector();
			fila.add(1+i);
			fila.add("a"+i);
			this.rowDataSer.add(fila);
			System.out.println(fila.toString());
		}*/
		id_grupos.clear();
		for(String grupo: grupos)
		{
			Vector fila = new Vector();
			//fila.add(1+i);
			//fila.add("a"+i);
			
			StringTokenizer st = new StringTokenizer(grupo, "$");
			fila.add(st.nextToken().trim());
			fila.add(st.nextToken().trim());
			id_grupos.add(Integer.parseInt(st.nextToken().trim()));
			this.rowDataSer.add(fila);
			System.out.println(fila.toString());
		}
		// refrescar el JTable dentro del JScrollPane:
		tablaGrupos = new JTable(this.rowDataSer, this.columSerV);
		System.out.println("#ser");
		scrollPane.setViewportView(tablaGrupos);// refresca el JTable

		return tablaGrupos;
	}
	public void seleccionarG()
	{
		int filaS = tablaGrupos.getSelectedRow();
		if(filaS != -1){
			
			principal.grupoActual = id_grupos.get(filaS);
			
			
			menu.navGruposNor();
			menu.tutoGrupo();
			
			
			}
			else {
				JOptionPane.showMessageDialog(null, "No ha seleccionado ningun servicio");
			}
	}
	
	
}
