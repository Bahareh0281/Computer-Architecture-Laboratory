/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/Qazal/Desktop/project8/tb_irreceiver.vhd";
extern char *IEEE_P_2592010699;

unsigned char ieee_p_2592010699_sub_1690584930_503743352(char *, unsigned char );


static void work_a_3043433382_1235688601_p_0(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;

LAB0:    xsi_set_current_line(46, ng0);

LAB3:    t1 = (t0 + 1672U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = ieee_p_2592010699_sub_1690584930_503743352(IEEE_P_2592010699, t3);
    t1 = (t0 + 4264);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = t4;
    xsi_driver_first_trans_fast(t1);

LAB2:    t9 = (t0 + 4168);
    *((int *)t9) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_3043433382_1235688601_p_1(char *t0)
{
    char *t1;
    char *t2;
    int64 t3;
    int64 t4;
    char *t5;
    unsigned char t6;
    unsigned char t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;

LAB0:    xsi_set_current_line(49, ng0);

LAB3:    t1 = (t0 + 2128U);
    t2 = *((char **)t1);
    t3 = *((int64 *)t2);
    t4 = (t3 / 2);
    t1 = (t0 + 1032U);
    t5 = *((char **)t1);
    t6 = *((unsigned char *)t5);
    t7 = ieee_p_2592010699_sub_1690584930_503743352(IEEE_P_2592010699, t6);
    t1 = (t0 + 4328);
    t8 = (t1 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    *((unsigned char *)t11) = t7;
    xsi_driver_first_trans_delta(t1, 0U, 1, t4);
    t12 = (t0 + 4328);
    xsi_driver_intertial_reject(t12, t4, t4);

LAB2:    t13 = (t0 + 4184);
    *((int *)t13) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_3043433382_1235688601_p_2(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    int t4;
    int t5;
    char *t6;
    char *t7;
    int t8;
    int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    int64 t14;
    char *t15;
    unsigned char t16;
    char *t17;
    char *t18;

LAB0:    t1 = (t0 + 3848U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(57, ng0);
    t2 = (t0 + 7706);
    *((int *)t2) = 0;
    t3 = (t0 + 7710);
    *((int *)t3) = 72;
    t4 = 0;
    t5 = 72;

LAB4:    if (t4 <= t5)
        goto LAB5;

LAB7:    goto LAB2;

LAB5:    xsi_set_current_line(58, ng0);
    t6 = (t0 + 2248U);
    t7 = *((char **)t6);
    t6 = (t0 + 7706);
    t8 = *((int *)t6);
    t9 = (t8 - 0);
    t10 = (t9 * 1);
    xsi_vhdl_check_range_of_index(0, 72, 1, *((int *)t6));
    t11 = (8U * t10);
    t12 = (0 + t11);
    t13 = (t7 + t12);
    t14 = *((int64 *)t13);
    t15 = (t0 + 3656);
    xsi_process_wait(t15, t14);

LAB10:    *((char **)t1) = &&LAB11;

LAB1:    return;
LAB6:    t2 = (t0 + 7706);
    t4 = *((int *)t2);
    t3 = (t0 + 7710);
    t5 = *((int *)t3);
    if (t4 == t5)
        goto LAB7;

LAB12:    t8 = (t4 + 1);
    t4 = t8;
    t6 = (t0 + 7706);
    *((int *)t6) = t4;
    goto LAB4;

LAB8:    xsi_set_current_line(59, ng0);
    t2 = (t0 + 2368U);
    t3 = *((char **)t2);
    t2 = (t0 + 7706);
    t8 = *((int *)t2);
    t9 = (t8 - 0);
    t10 = (t9 * 1);
    xsi_vhdl_check_range_of_index(0, 72, 1, *((int *)t2));
    t11 = (1U * t10);
    t12 = (0 + t11);
    t6 = (t3 + t12);
    t16 = *((unsigned char *)t6);
    t7 = (t0 + 4392);
    t13 = (t7 + 56U);
    t15 = *((char **)t13);
    t17 = (t15 + 56U);
    t18 = *((char **)t17);
    *((unsigned char *)t18) = t16;
    xsi_driver_first_trans_fast(t7);
    goto LAB6;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

}


extern void work_a_3043433382_1235688601_init()
{
	static char *pe[] = {(void *)work_a_3043433382_1235688601_p_0,(void *)work_a_3043433382_1235688601_p_1,(void *)work_a_3043433382_1235688601_p_2};
	xsi_register_didat("work_a_3043433382_1235688601", "isim/nec_receiver_testbench_isim_beh.exe.sim/work/a_3043433382_1235688601.didat");
	xsi_register_executes(pe);
}
