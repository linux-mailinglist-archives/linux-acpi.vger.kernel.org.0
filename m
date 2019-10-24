Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0F45E3C0B
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Oct 2019 21:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391505AbfJXTfo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Oct 2019 15:35:44 -0400
Received: from mail-eopbgr130054.outbound.protection.outlook.com ([40.107.13.54]:18243
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391088AbfJXTfn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 24 Oct 2019 15:35:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cN9Q/7Wyowfv2msZJyTTlngHiMa7teIamQqDci3Uy8AoV8LQJz+shT+jCSQf/oIkzfKD5kk46SBvy1pIWW/mAOfa8yLeXwLeMQjGzsGTCfqx7BSELb25/TUg/lo9vuKPQssY5uRbjaYaW32QqgjjHjfK7XhqjmoDcyNLqES6I5cANk6wFQmM14j05D+2zXoRQejMIoo73isym/ko86xRVenK/eUHhW4YypPcjnTqu2ep/REi9AW0xpv+XOUPkw/ND0RXVCTQtXV6dtGQzujO0fJSjqgEsXzQcUI0NSChk7Or9hYqCBkDipIUxaZA1wT0cH7n7nskKto15AGqAsjb4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXImPREJvpn4T1Ft0gtPPdk6aLME9Ww4vx2zVcbnFPI=;
 b=hgNQbdZb7HPJjgQOyRvSNIlYEkXiXU7S9UjSK2lUmJsNXbJka0qKGnR38gkn+i6ZFXzEW0E+BezfWrg0Owa6QSpFOsbfvUW37V+26wb5e0trIbFTtfFgBzvJ8qgpYY8YJVXkisK31M0U4nlft6dPISsDmF/S66Z8moE1T51FpN4GUwSDyO59B+2hsbqHuK4kK+ApeS3a8Jzb1KGuJqgxEnmR5r/b4YpsP5sx4Vf/K9p9taLodflqby4+orvnZt9zIEjEhiQ1rU1iOd4ch4kpa0htcyWZuzpMZOmGsbvbqgXyK9QmdcYHs7vHug4imC12sP+6IaeflKdWVxtG4MmsXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXImPREJvpn4T1Ft0gtPPdk6aLME9Ww4vx2zVcbnFPI=;
 b=eVdV8WPDpMmJDGev7uZE6tNbORoA/A7pccDEljRLGutvEpM8nc4hTNJz07aaH4hMKJXtwnQMP9ABJ6mpGEeVTjBNFNAGFj4dbrAjcUwVurx2UqzdH4cU6BaaUtnXviAHB6OcLozYW3rhB6w/H4ZrEVdF1qLtK9cBLsk6DIonc+0=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB6061.eurprd04.prod.outlook.com (20.179.25.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.20; Thu, 24 Oct 2019 19:34:59 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::24fb:fb99:b1c6:ba1f]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::24fb:fb99:b1c6:ba1f%4]) with mapi id 15.20.2387.021; Thu, 24 Oct 2019
 19:34:59 +0000
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
Date:   Thu, 24 Oct 2019 19:34:59 +0000
Message-ID: <VI1PR04MB70234EB305F60855491EBFDDEE6A0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <2811202.iOFZ6YHztY@kreacher> <4551555.oysnf1Sd0E@kreacher>
 <VI1PR04MB7023ECFFD42193CF864524ACEE6A0@VI1PR04MB7023.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c6efb7da-5afb-4dc2-ac8b-08d758b94208
x-ms-traffictypediagnostic: VI1PR04MB6061:
x-microsoft-antispam-prvs: <VI1PR04MB60611DE784B381334A88B71AEE6A0@VI1PR04MB6061.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(189003)(199004)(25786009)(14444005)(26005)(6506007)(99286004)(76176011)(7696005)(53546011)(102836004)(4326008)(71200400001)(91956017)(6246003)(76116006)(110136005)(14454004)(316002)(54906003)(186003)(33656002)(66476007)(64756008)(66446008)(66556008)(2906002)(44832011)(486006)(446003)(66946007)(9686003)(256004)(476003)(55016002)(305945005)(7736002)(3846002)(6116002)(5660300002)(74316002)(86362001)(52536014)(229853002)(81166006)(6436002)(81156014)(8676002)(478600001)(8936002)(66066001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6061;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qPqVS3OWlRiG0uOYGUE1jHR5GGLwj5QR62lF5Oc+EqSsVp3Js2rTIgttu0KJX6bH7AXWcOl+IqKQE92T0pyvigdmTFTrFbTHkxsAss8HUPjW4Qhwukb3MFz41VBnBTwdtaz1PocbglmoQZcvY0GYn+XLGmnYUp2DX90jSVEkg7SZFhRb46JofVmYApkH+uV2eTcxPLWSVsIGKBPhrLJBsUbfhiCinbzcoZGKjXGmVRzvgVIXIZUtWwe+ePQkwIJZymsot3daBbFMYmd9xkhfPoaj38JQhYQKkU8YXPOePEFT+0ExlTgIjSW1uODLFDusT8kL8M4KIgLNv3CSeIeWfb6DPWiydQJvBaZxrdLDdjesHBCN1jsNk1dpKUmvi9GH26q7QLJrhzd6/wLWlE119DouUloyspWrlZ1tI5Z8YvCHHs/DylbW5yRJkqKH1F8Z
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6efb7da-5afb-4dc2-ac8b-08d758b94208
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 19:34:59.5765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KdCTBZJfWmrP0PkF5mKuwWIAC7FW7T6LaKqkgPuuiV/NklpmFSikUTq9csnzyrJViVaWLeel/AOioOt9iY0Trw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6061
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 24.10.2019 22:01, Leonard Crestez wrote:=0A=
> On 16.10.2019 13:48, Rafael J. Wysocki wrote:=0A=
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>=0A=
>>=0A=
>> Introduce frequency QoS, based on the "raw" low-level PM QoS, to=0A=
>> represent min and max frequency requests and aggregate constraints.=0A=
>>=0A=
>> The min and max frequency requests are to be represented by=0A=
>> struct freq_qos_request objects and the aggregate constraints are to=0A=
>> be represented by struct freq_constraints objects.  The latter are=0A=
>> expected to be initialized with the help of freq_constraints_init().=0A=
>>=0A=
>> The freq_qos_read_value() helper is defined to retrieve the aggregate=0A=
>> constraints values from a given struct freq_constraints object and=0A=
>> there are the freq_qos_add_request(), freq_qos_update_request() and=0A=
>> freq_qos_remove_request() helpers to manipulate the min and max=0A=
>> frequency requests.  It is assumed that the the helpers will not=0A=
>> run concurrently with each other for the same struct freq_qos_request=0A=
>> object, so if that may be the case, their uses must ensure proper=0A=
>> synchronization between them (e.g. through locking).=0A=
>>=0A=
>> In addition, freq_qos_add_notifier() and freq_qos_remove_notifier()=0A=
>> are provided to add and remove notifiers that will trigger on aggregate=
=0A=
>> constraint changes to and from a given struct freq_constraints object,=
=0A=
>> respectively.=0A=
>>=0A=
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>=0A=
>> ---=0A=
>>    include/linux/pm_qos.h |   44 ++++++++=0A=
>>    kernel/power/qos.c     |  240 +++++++++++++++++++++++++++++++++++++++=
++++++++++=0A=
>>    2 files changed, 284 insertions(+)=0A=
>>=0A=
>> Index: linux-pm/include/linux/pm_qos.h=0A=
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
>> --- linux-pm.orig/include/linux/pm_qos.h=0A=
>> +++ linux-pm/include/linux/pm_qos.h=0A=
>> @@ -267,4 +267,48 @@ static inline s32 dev_pm_qos_raw_resume_=0A=
>>    }=0A=
>>    #endif=0A=
>>    =0A=
>> +#define FREQ_QOS_MIN_DEFAULT_VALUE	0=0A=
>> +#define FREQ_QOS_MAX_DEFAULT_VALUE	(-1)=0A=
>> +=0A=
>> +enum freq_qos_req_type {=0A=
>> +	FREQ_QOS_MIN =3D 1,=0A=
>> +	FREQ_QOS_MAX,=0A=
>> +};=0A=
>> +=0A=
>> +struct freq_constraints {=0A=
>> +	struct pm_qos_constraints min_freq;=0A=
>> +	struct blocking_notifier_head min_freq_notifiers;=0A=
>> +	struct pm_qos_constraints max_freq;=0A=
>> +	struct blocking_notifier_head max_freq_notifiers;=0A=
> =0A=
> These min/max_freq_notifiers fields seem unused? They're initialized but=
=0A=
> the freq_qos_add/remove_notifier calls use min/max_freq.notifiers directl=
y.=0A=
> =0A=
> Should probably just be dropped.=0A=
=0A=
Never mind, I see now that pm_qos_constraints.notifiers is actually a =0A=
pointer to notifier block provided by somebody else.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
