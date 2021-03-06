
package splitpay;

import Controladores.CuentaJpaController;
import Controladores.GrupoJpaController;
import Controladores.UsuarioJpaController;
import Negocio.Grupo;
import Negocio.Usuario;
import java.math.BigDecimal;

import java.util.List;
import java.util.Vector;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.swing.JTable;

/**
 *
 * @author Pablo
 */
public class SplitPay {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
    	EntityManagerFactory emf = Persistence.createEntityManagerFactory("SplitPayPU");
	CuentaJpaController contro = new CuentaJpaController(emf);
        /*
        List<String> fechas = contro.fechas();
	for( String fecha : fechas )
        {
            System.out.println(fecha);   
        }
        System.out.println(contro.numBillsPorFecha((int)3, "2016-febrero"));
        GrupoJpaController controG = new GrupoJpaController(emf);
        List<BigDecimal> gruposID = controG.listaID();
        for( BigDecimal id : gruposID )
        {
            System.out.println("id: " + id);
            System.out.println("Total: " + contro.totalPorGrupo(id.intValue()));
        }
        List<String> nombres = controG.listaNombre();
        for( String nombre : nombres )
        {
            System.out.println(nombre);
        }
        */
        UsuarioJpaController controUsu = new UsuarioJpaController(emf) ;
        controUsu.RealizarBalanceGruposdeUsuario(1);
        List<Usuario> usuarios = controUsu.usuariosDeUnGrupo(1);
        for( Usuario user : usuarios )
            System.out.println(user);
        usuarios = controUsu.contactos(1);
        for( Usuario user : usuarios )
            System.out.println(user);
        controUsu.RealizarBalanceGruposdeUsuario(1);
        CuentaJpaController controCuenta = new CuentaJpaController(emf) ;
        //controCuenta.TablaUsuarioCuentaGrupo(1) ;
    }
    
    
    /*public void mostrarDatos() {
    EntityManagerFactory emf = Persistence.createEntityManagerFactory("SplitPayPU");
    CuentaJpaController controCuenta = new CuentaJpaController(emf);
    List<Object[]> cuentas = controCuenta.todasCuenta();
    for( int i=0 ; i<cuentas.size();i++) {
    Vector fila = new Vector();
    fila.add(cuentas.get(i)[1]);
    fila.add(cuentas.get(i)[2]) ;
    rowDataSer.add(fila);
    BigDecimal idCu = (BigDecimal)cuentas.get(i)[0];
    idCuenta.add(idCu.intValueExact());
    }
    tableCuenta = new JTable(rowDataSer, columSerV);
    scrollPane.setViewportView(tableCuenta);
    emf.close();
    }*/
}
