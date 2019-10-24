Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D193AE3B88
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Oct 2019 21:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504207AbfJXTBN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Oct 2019 15:01:13 -0400
Received: from mail-eopbgr50046.outbound.protection.outlook.com ([40.107.5.46]:37602
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390493AbfJXTBN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 24 Oct 2019 15:01:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaLtFPqzdBsGS1JDWvH4l0EYMtL36HWnBv3E0j3KuZMJ6Y1vElj8prQVXD77x7G65cC57iOiGCzxMGcWyQ/N0NBzWPHfubj+inEzLLijoCthpmpyhcvUsESlCfiu/Zc590mmXXM8no+Joud0av8FJPSJwvkujvZ8yqXZVAtRprrspfsmxIWkxeQmWK9C2OvYvDlhHn97Hoo5L4ACI937jsRjUz8TdW3qCZoLTB/pUBOQTJnyxRR9NSEkN3tJ/Ag5sq6BUIf2f7iWykaWGUWZw3xFZNS2sxb0oMfDUgvoaTwIvxZNw5rwDlrVm9qATaK4MDPufr52KqMAEJmrIR2gZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zv83pBhhvhC/AE3+V0PGUH8Tbea2jtn3KS1w9lHeYj4=;
 b=K+yQkb7GNFpZLUDCCEEZkrU4RtIz4PZfywuoU7A3aO0psR7Jx0ij90ChsonHTUMWW6wkhpiJ2pABkz39UlC/beXwNprPqwnCSI6NY/75KMOHcvvIzapjOyMXJbup+Gv4FGFv/vgcTTmJeQwwRhs0ijt3twgbwXWd86FnIiZNDmUobny09o13fnYM2XpmuA2pVKeZVSl9V2/aqSMZHe8cgeN6tFj+I3NySnSp1JQ+/HTtKl6lqtYt6qv53Hse/Hzdwclai/AAjvBcl1BlIKZKjz29HUmq+nqJo0fQZq4P0rwkgAT139mNCm9eH14wp8KQCIWcq+VpMDjVX0GxJHaDRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zv83pBhhvhC/AE3+V0PGUH8Tbea2jtn3KS1w9lHeYj4=;
 b=bIdD/WgHKI/U5KPeZVM/ThWlvw3+frIwO0vOkLDEZXssk1xjzIr2qyUtwPLmX4i/kDV5KPjV5yR2hnNxuUa29tniRXLRQr1f+z+XaFSBT+G5ctU+kBolv1x1DZodBiY0etSkaLRGOowitD3aTiOLWn87aKpfb1XgCcStsqk30Lc=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB3966.eurprd04.prod.outlook.com (10.171.183.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Thu, 24 Oct 2019 19:01:07 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::24fb:fb99:b1c6:ba1f]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::24fb:fb99:b1c6:ba1f%4]) with mapi id 15.20.2387.021; Thu, 24 Oct 2019
 19:01:07 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [RFT][PATCH 1/3] PM: QoS: Introduce frequency QoS
Thread-Topic: [RFT][PATCH 1/3] PM: QoS: Introduce frequency QoS
Thread-Index: AQHVhA83pBLldkQGO0OkZWmZhR1Vyw==
Date:   Thu, 24 Oct 2019 19:01:06 +0000
Message-ID: <VI1PR04MB7023ECFFD42193CF864524ACEE6A0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <2811202.iOFZ6YHztY@kreacher> <4551555.oysnf1Sd0E@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b3682192-cbc4-41a9-4740-08d758b48681
x-ms-traffictypediagnostic: VI1PR04MB3966:
x-microsoft-antispam-prvs: <VI1PR04MB3966E9EA5AD955B0E2FF16A4EE6A0@VI1PR04MB3966.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(199004)(189003)(76176011)(52536014)(5660300002)(186003)(102836004)(86362001)(99286004)(6246003)(26005)(7696005)(71200400001)(71190400001)(53546011)(6506007)(14444005)(256004)(66066001)(6436002)(14454004)(6116002)(3846002)(74316002)(446003)(76116006)(476003)(55016002)(66946007)(66556008)(66476007)(64756008)(66446008)(2906002)(91956017)(7736002)(54906003)(110136005)(305945005)(8936002)(8676002)(81156014)(4326008)(81166006)(498600001)(33656002)(9686003)(229853002)(25786009)(44832011)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3966;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pZCKViUryeBYAKXKBT+EbpqqXeTfGzDWkheqoWBSs28r9RbB7dPuFtE44SYY5ms9gxHIuy33JJxRy8YwgQrBU0ek1qLCN2U1WWIxeHLBb/Uqu2IXm1FvbyY24gQpJfQkI1Q0d9G9vPURA69DXkyJAgIReCcYGacX6PXrQBQo944UjIeK7GWlyJOEv8FnpM+xnXNRdKxBBJifa5GKwjVngphulVss5AJE7KqfGgB6scLoyOW65FZ+ZPDDmZcs+HX1exjoNT2MjnWAfA2N+VvCLe8pruog4xk1ELgF0dnTIqsQrSZpjCupqpxN+qn7NI7pCDFJLctUvRMThX1LsfPFpFiqltAITBC+EQThyqpy2iG2/OO8d4OdyOCJ2r9oC0+MxB2H22Rn2narzAON8AI8UbOFGvvb4Q4dtgH9egaoawWEMELNCrz4SbIBhU2f+8Vr
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3682192-cbc4-41a9-4740-08d758b48681
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 19:01:06.9255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gNB78dI+iCl2XNUK1nBxYnc3Djf5OrZRfUkyXwOYyWrWfPA8/5P6TQ5J73KfvCrofCbNrk1CHKG98kMrNTj6zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3966
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 16.10.2019 13:48, Rafael J. Wysocki wrote:=0A=
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>=0A=
> =0A=
> Introduce frequency QoS, based on the "raw" low-level PM QoS, to=0A=
> represent min and max frequency requests and aggregate constraints.=0A=
> =0A=
> The min and max frequency requests are to be represented by=0A=
> struct freq_qos_request objects and the aggregate constraints are to=0A=
> be represented by struct freq_constraints objects.  The latter are=0A=
> expected to be initialized with the help of freq_constraints_init().=0A=
> =0A=
> The freq_qos_read_value() helper is defined to retrieve the aggregate=0A=
> constraints values from a given struct freq_constraints object and=0A=
> there are the freq_qos_add_request(), freq_qos_update_request() and=0A=
> freq_qos_remove_request() helpers to manipulate the min and max=0A=
> frequency requests.  It is assumed that the the helpers will not=0A=
> run concurrently with each other for the same struct freq_qos_request=0A=
> object, so if that may be the case, their uses must ensure proper=0A=
> synchronization between them (e.g. through locking).=0A=
> =0A=
> In addition, freq_qos_add_notifier() and freq_qos_remove_notifier()=0A=
> are provided to add and remove notifiers that will trigger on aggregate=
=0A=
> constraint changes to and from a given struct freq_constraints object,=0A=
> respectively.=0A=
> =0A=
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>=0A=
> ---=0A=
>   include/linux/pm_qos.h |   44 ++++++++=0A=
>   kernel/power/qos.c     |  240 +++++++++++++++++++++++++++++++++++++++++=
++++++++=0A=
>   2 files changed, 284 insertions(+)=0A=
> =0A=
> Index: linux-pm/include/linux/pm_qos.h=0A=
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
> --- linux-pm.orig/include/linux/pm_qos.h=0A=
> +++ linux-pm/include/linux/pm_qos.h=0A=
> @@ -267,4 +267,48 @@ static inline s32 dev_pm_qos_raw_resume_=0A=
>   }=0A=
>   #endif=0A=
>   =0A=
> +#define FREQ_QOS_MIN_DEFAULT_VALUE	0=0A=
> +#define FREQ_QOS_MAX_DEFAULT_VALUE	(-1)=0A=
> +=0A=
> +enum freq_qos_req_type {=0A=
> +	FREQ_QOS_MIN =3D 1,=0A=
> +	FREQ_QOS_MAX,=0A=
> +};=0A=
> +=0A=
> +struct freq_constraints {=0A=
> +	struct pm_qos_constraints min_freq;=0A=
> +	struct blocking_notifier_head min_freq_notifiers;=0A=
> +	struct pm_qos_constraints max_freq;=0A=
> +	struct blocking_notifier_head max_freq_notifiers;=0A=
=0A=
These min/max_freq_notifiers fields seem unused? They're initialized but =
=0A=
the freq_qos_add/remove_notifier calls use min/max_freq.notifiers directly.=
=0A=
=0A=
Should probably just be dropped.=0A=
=0A=
> +/**=0A=
> + * freq_qos_add_notifier - Add frequency QoS change notifier.=0A=
> + * @qos: List of requests to add the notifier to.=0A=
> + * @type: Request type.=0A=
> + * @notifier: Notifier block to add.=0A=
> + */=0A=
> +int freq_qos_add_notifier(struct freq_constraints *qos,=0A=
> +			  enum freq_qos_req_type type,=0A=
> +			  struct notifier_block *notifier)=0A=
> +{=0A=
> +	int ret;=0A=
> +=0A=
> +	if (IS_ERR_OR_NULL(qos) || !notifier)=0A=
> +		return -EINVAL;=0A=
> +=0A=
> +	switch (type) {=0A=
> +	case FREQ_QOS_MIN:=0A=
> +		ret =3D blocking_notifier_chain_register(qos->min_freq.notifiers,=0A=
> +						       notifier);=0A=
> +		break;=0A=
> +	case FREQ_QOS_MAX:=0A=
> +		ret =3D blocking_notifier_chain_register(qos->max_freq.notifiers,=0A=
> +						       notifier);=0A=
> +		break;=0A=
> +	default:=0A=
> +		WARN_ON(1);=0A=
> +		ret =3D -EINVAL;=0A=
> +	}=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +EXPORT_SYMBOL_GPL(freq_qos_add_notifier);=0A=
> +=0A=
> +/**=0A=
> + * freq_qos_remove_notifier - Remove frequency QoS change notifier.=0A=
> + * @qos: List of requests to remove the notifier from.=0A=
> + * @type: Request type.=0A=
> + * @notifier: Notifier block to remove.=0A=
> + */=0A=
> +int freq_qos_remove_notifier(struct freq_constraints *qos,=0A=
> +			     enum freq_qos_req_type type,=0A=
> +			     struct notifier_block *notifier)=0A=
> +{=0A=
> +	int ret;=0A=
> +=0A=
> +	if (IS_ERR_OR_NULL(qos) || !notifier)=0A=
> +		return -EINVAL;=0A=
> +=0A=
> +	switch (type) {=0A=
> +	case FREQ_QOS_MIN:=0A=
> +		ret =3D blocking_notifier_chain_unregister(qos->min_freq.notifiers,=0A=
> +							 notifier);=0A=
> +		break;=0A=
> +	case FREQ_QOS_MAX:=0A=
> +		ret =3D blocking_notifier_chain_unregister(qos->max_freq.notifiers,=0A=
> +							 notifier);=0A=
> +		break;=0A=
> +	default:=0A=
> +		WARN_ON(1);=0A=
> +		ret =3D -EINVAL;=0A=
> +	}=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +EXPORT_SYMBOL_GPL(freq_qos_remove_notifier);=0A=
