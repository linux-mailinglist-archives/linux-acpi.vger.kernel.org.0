Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 651912EA14
	for <lists+linux-acpi@lfdr.de>; Thu, 30 May 2019 03:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfE3BHM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 May 2019 21:07:12 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:47636 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726884AbfE3BHM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 29 May 2019 21:07:12 -0400
X-Greylist: delayed 21396 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 May 2019 21:07:12 EDT
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4TJAFc5004806
        for <linux-acpi@vger.kernel.org>; Wed, 29 May 2019 15:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=qVmkS7iq5LvUsgvqZyT30GT4rWjXJkd+2oTu15AyTJA=;
 b=hMx3aGy5ivI47shMQXceKaxxLe+F2Tmwn+cvQNDzdpX8t6TuBm9WeS0+ohdxnhG8v0Vq
 oQbP0q44+ZSTWlv25HYRV1rbZagLtN2JFmhNBk/2Ckt/l9KRZwYRxY/PEWGRcres+IoC
 XNWlUNBWB6foLVHLp7FJy6n9j12DKtfmaOs9AzrtfxUnXjEEEtzIdjP2DFJ2QPlqyyPn
 Pyd3+FII7HqohHzHHhUW42zrGmmLvAYPjBD3Xf85o3JfhUxxc24RtCg3bVsc3rX1W9bt
 Ic+OleOOjC7RoUHUeUajuu0Jc6k8S7M+6mbiTXmdbI8GAMOa9wRE6rpJ7n9kp96DuWh7 gA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2sspwpjksj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-acpi@vger.kernel.org>; Wed, 29 May 2019 15:10:35 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4TJ8LeF120417
        for <linux-acpi@vger.kernel.org>; Wed, 29 May 2019 15:10:34 -0400
Received: from ausxippc110.us.dell.com (AUSXIPPC110.us.dell.com [143.166.85.200])
        by mx0a-00154901.pphosted.com with ESMTP id 2spyxvgk5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-acpi@vger.kernel.org>; Wed, 29 May 2019 15:10:34 -0400
X-LoopCount0: from 10.166.132.130
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="802413538"
From:   <Mario.Limonciello@dell.com>
To:     <shaunak.saha@intel.com>, <linux-acpi@vger.kernel.org>
CC:     <rafael.j.wysocki@intel.com>
Subject: RE: drivers/acpi: Change the lpit function call flow
Thread-Topic: drivers/acpi: Change the lpit function call flow
Thread-Index: AQHVFAKKjgBVcnZ72kWZF+/9z/EG9qaCe3Hg
Date:   Wed, 29 May 2019 19:10:32 +0000
Message-ID: <e194fa374cb64106b7a34fff616734c2@AUSX13MPC105.AMER.DELL.COM>
References: <20190526202750.4614-1-shaunak.saha@intel.com>
In-Reply-To: <20190526202750.4614-1-shaunak.saha@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-29_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=978 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905290124
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905290124
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Shaunak Saha <shaunak.saha@intel.com>
> Sent: Sunday, May 26, 2019 3:28 PM
> To: linux-acpi@vger.kernel.org
> Cc: rafael.j.wysocki@intel.com; Limonciello, Mario; Shaunak Saha
> Subject: drivers/acpi: Change the lpit function call flow
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> In the present implementation sleep function was getting called in
> acpi_s2idle_prepare and as all the devices may not have suspended
> at that stage e.g. if we are telling ec about the S0ix then calling early
> can cause ec reply wrongly interpreted as spurious wake events.
> Here we call it at much later stage in acpi_s2idle_sync. As per the
> specification the entry _DSM function may be invoked when the OS state ha=
s
> reached sufficient criteria for processor idle state entry matching
> Entry Trigger defined in LPIT to be interpreted as a request for the
> platform to enter a Low Power S0 Idle (LPI) state. Here we are checking i=
f
> the we reached the minimum D-State defined in the constraint function of
> the LPIT _DSM method before calling the sleep entry function. Also not
> checking for constraint in acpi_s2idle_wake anymore and also changed the
> acpi info loglevel to debug in lpi_check_constraint.
>=20
> Signed-off-by: Shaunak Saha <shaunak.saha@intel.com>

I did test this patch on an XPS 9380 and can confirm that it prevents the d=
evice from
going in/out of S2I twice in a row.

I was not able to test the config option related to constraints blocking en=
try because
an I2C device was preventing this on this system.

Tested-by: Mario Limonciello <mario.limonciello@dell.com>
> ---
>  drivers/acpi/Kconfig | 13 +++++++++
>  drivers/acpi/sleep.c | 76 +++++++++++++++++++++++++++++++++++++++++++---=
-----
> -
>  2 files changed, 77 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 283ee94..57a9b2e 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -93,6 +93,19 @@ config ACPI_LPIT
>  	depends on X86_64
>  	default y
>=20
> +config LPIT_CONSTRAINTS_CHECK_FAILURE
> +	bool
> +	depends on X86_64
> +	default n
> +	help
> +	  For platforms defining the device constraints _DSM function in the
> +	  Low Power Idle table this option allows the platform to choose
> +	  if they wants to fail or succeed in calling the Low Power Entry
> +	  Notification _DSM function. If this config is defined by a
> +	  platform then the Low Power S0 Entry Notification _DSM function
> +	  is not called if the idle state has not achieved the Entry Trigger
> +	  defined in LPIT.
> +
>  config ACPI_SLEEP
>  	bool
>  	depends on SUSPEND || HIBERNATION
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index e52f123..9f2359c 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -860,11 +860,25 @@ static void lpi_device_get_constraints(void)
>=20
>  free_acpi_buffer:
>  	ACPI_FREE(out_obj);
> +	/*
> +	 * lpi_constraints_table_size only increments if we have proper package
> +	 * definitions for the constraints, its done after parsing all the
> +	 * fields for constraints. Memory is allocated for lpi_constraints_tabl=
e
> +	 * through kcalloc much before we start parsing the packages we need to
> +	 * free the memory here in case of any failures.
> +	 */
> +	if (!lpi_constraints_table_size && lpi_constraints_table)
> +		kfree(lpi_constraints_table);
>  }
>=20
> -static void lpi_check_constraints(void)
> +static int lpi_check_constraints(void)
>  {
>  	int i;
> +	int lpi_error =3D 0;
> +
> +	/* We do not have any table so return from here */
> +	if (!lpi_constraints_table_size)
> +		return lpi_error;
>=20
>  	for (i =3D 0; i < lpi_constraints_table_size; ++i) {
>  		acpi_handle handle =3D lpi_constraints_table[i].handle;
> @@ -879,17 +893,21 @@ static void lpi_check_constraints(void)
>  			acpi_power_state_string(adev->power.state));
>=20
>  		if (!adev->flags.power_manageable) {
> -			acpi_handle_info(handle, "LPI: Device not power
> manageable\n");
> +			acpi_handle_debug(handle, "LPI: Device not power
> manageable\n");
>  			lpi_constraints_table[i].handle =3D NULL;
>  			continue;
>  		}
>=20
> -		if (adev->power.state < lpi_constraints_table[i].min_dstate)
> -			acpi_handle_info(handle,
> +		if (adev->power.state < lpi_constraints_table[i].min_dstate) {
> +			acpi_handle_debug(handle,
>  				"LPI: Constraint not met; min power state:%s
> current power state:%s\n",
>=20
> 	acpi_power_state_string(lpi_constraints_table[i].min_dstate),
>  				acpi_power_state_string(adev->power.state));
> +			/* Error is set here if any of the constraints fail */
> +			lpi_error =3D 1;
> +		}
>  	}
> +	return lpi_error;
>  }
>=20
>  static void acpi_sleep_run_lps0_dsm(unsigned int func)
> @@ -967,12 +985,8 @@ static int acpi_s2idle_begin(void)
>=20
>  static int acpi_s2idle_prepare(void)
>  {
> -	if (lps0_device_handle) {
> -		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
> -		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
> -
> +	if (lps0_device_handle)
>  		acpi_ec_set_gpe_wake_mask(ACPI_GPE_ENABLE);
> -	}
>=20
>  	if (acpi_sci_irq_valid())
>  		enable_irq_wake(acpi_sci_irq);
> @@ -990,9 +1004,6 @@ static void acpi_s2idle_wake(void)
>  	if (!lps0_device_handle)
>  		return;
>=20
> -	if (pm_debug_messages_on)
> -		lpi_check_constraints();
> -
>  	/*
>  	 * If IRQD_WAKEUP_ARMED is not set for the SCI at this point, it means
>  	 * that the SCI has triggered while suspended, so cancel the wakeup in
> @@ -1013,6 +1024,7 @@ static void acpi_s2idle_wake(void)
>=20
>  static void acpi_s2idle_sync(void)
>  {
> +	int lpi_check;
>  	/*
>  	 * Process all pending events in case there are any wakeup ones.
>  	 *
> @@ -1023,6 +1035,46 @@ static void acpi_s2idle_sync(void)
>  	acpi_ec_flush_work();
>  	acpi_os_wait_events_complete();	/* synchronize Notify handling */
>  	s2idle_wakeup =3D false;
> +
> +	if (!lps0_device_handle)
> +		return;
> +
> +	acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
> +
> +	/*
> +	 * Check here if device constraints(Function 1) is defined.
> +	 * If only the sleep functions are defined in lpit we run that here.
> +	 */
> +	if (!lpi_constraints_table_size)
> +		goto lps0_entry;
> +
> +	lpi_check =3D lpi_check_constraints();
> +
> +	/*
> +	 * _DSM function may be invoked when the OS state
> +	 * has reached sufficient criteria for processor idle
> +	 * state.
> +	 */
> +	if (lpi_check) {
> +		/*
> +		 * We check the config LPIT_CONSTRAINTS_FAILURE
> +		 * here for the devices which defines the constraints
> +		 * properly and LPIT_CONSTRAINTS_FAILURE config in kernel.
> +		 * We fail here if constraints are not met. But we still run
> +		 * the sleep function for the devices which do not define
> +		 * the LPIT_CONSTRAINTS_FAILURE kernel config.
> +		 */
> +		if (!IS_ENABLED(CONFIG_LPIT_CONSTRAINTS_CHECK_FAILURE))
> +			goto lps0_entry;
> +
> +		return;
> +	}
> +
> +lps0_entry:
> +	/*
> +	 * If only the sleep functions are defined in lpit we run that here.
> +	 */
> +	acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
>  }
>=20
>  static void acpi_s2idle_restore(void)

