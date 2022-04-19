/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package lt.bit.buhalterijawebjpa.data;

import java.math.BigDecimal;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


@Entity
@Table (name="prekes")
public class Preke {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    @ManyToOne
    @JoinColumn(name="cekis_id")
    private Cekis cekis;
    private String preke;
    private BigDecimal suma;
    
    @ManyToOne
    @JoinColumn(name="paskirtis_id")
    private Paskirtis paskirtis;

    public Preke() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Cekis getCekis() {
        return cekis;
    }

    public void setCekis(Cekis cekis) {
        this.cekis = cekis;
    }

    public String getPreke() {
        return preke;
    }

    public void setPreke(String preke) {
        this.preke = preke;
    }

    public BigDecimal getSuma() {
        return suma;
    }

    public void setSuma(BigDecimal suma) {
        this.suma = suma;
    }

    public Paskirtis getPaskirtis() {
        return paskirtis;
    }

    public void setPaskirtis(Paskirtis paskirtis) {
        this.paskirtis = paskirtis;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 67 * hash + this.id;
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Preke other = (Preke) obj;
        if (this.id != other.id) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Preke{" + "id=" + id + ", cekis=" + cekis + ", preke=" + preke + ", suma=" + suma + ", paskirtis=" + paskirtis + '}';
    }
    
    
}
