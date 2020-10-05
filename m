Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE32A2836BC
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Oct 2020 15:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgJENkc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Oct 2020 09:40:32 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:58100 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725932AbgJENkb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Oct 2020 09:40:31 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095CpQ8r001018;
        Mon, 5 Oct 2020 08:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=MGEIRoMYkOfu8IOgegKB+525owgEhukG4g/yaYJO448=;
 b=WtgDfk+Dwje1pc21PG45mn4wwf7KFsmlDcr1jTwuFAedgoF/6HuS0U/Amx493CUwF16u
 ww8hjbroL4wYZWWz/9aCDa/1EatVxK53WRHYIzekcyyJm8B2PSmZwtQebfnDrP6tOTyc
 cNaM2fOJ+aYajSebx0tLsuJ18XrHPyYydccsQLrEG/wn6QCw0lwW7ciM+ZBR84gb273o
 mtuGMZEXr1AJ/6pJv/zhEvwyreoUAdsn+whERT0HaGVbh7Ko4b+oGdPbVbTRmv3UGRBJ
 9LnsZeoXBDRfgrz++3dlJS36W5GUUb0EEVVRL+mFoJSR56VaeUjefhKw64IzyCuomzob lw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 33xmc2cgtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 08:58:12 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095CrxLA046298;
        Mon, 5 Oct 2020 08:58:11 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by mx0a-00154901.pphosted.com with ESMTP id 33y6xuxv10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Oct 2020 08:58:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFyCkB0Q4YZrVssQtq2qNem3PkU5id6bFq2YvrDzyPtng89o/m1HYvBaM+zQqxsgG7laDJbEzHq9IEer5dfIENIR30gAk1M3Ws+2O9XY1buEWxptkiV2wGVmQtaOw2BnwW1L9QgwGHmhmhheIhSsEtabt8DIXc3eYPdqQqgGu5xPeOhyWgFQ/lrRaGloJfwSgRKGe/93rHE6E5Ss0NaGVzMKC8o4ETZFnHwHjmlKuncGvRSB+7kXukW2wrpmXZBVgpr03tLg/lcRly48yhPbxCN1hKNVQ/eqbxoy7ghpil/stDJsJ0PrVaP1jeDeNSeiWyDJhnAKX0g8L8Q6I1dH/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGEIRoMYkOfu8IOgegKB+525owgEhukG4g/yaYJO448=;
 b=lNV0W8bulLPwy7ViUqFxYVcJn6tJnbssdyRhg3fxxErTMzx/MQkaVpq5SEbfb+C5irkf72c0Si0E/+x3VzeZ6eoNtgQWKiJfM7cLTP11UitGBmKXDD1PcTqatNJijMzUZkCP/i0TsgEH5AYFBo6qqEHkPFvppEovrKt6LX1pjtAt5odOp+pQGODjri46MdsPrA5y/8oHjgoC4bjSLBvdXzpr1XDSk3OavuYR8nvTKZHYD98W3N10x8DQ9q3SD1Rg7FBQg9ueweoTdlpQikxfdkOqdwoKlomHfRe+3fsijeJIVJ2an6brNywvmfFsbAbW3+N993BMEtHTvyjqoEtokg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGEIRoMYkOfu8IOgegKB+525owgEhukG4g/yaYJO448=;
 b=WcWTaW2SSg7RxJD4oaY5iceJAdIFmCBbM/a8W4bOrGT6FIp9LIzt63/XHME47FK4wldNL+4iqMhWDBUpqUTGSaUSlfJOfN38OaIaCNAZ5Ozz4UZVd/CuqBG/MBARjN+9LKSNQUfhcv8MPia4YAfmTDiI1bQh8dfxGJnhDiYA1rU=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM6PR19MB4076.namprd19.prod.outlook.com (2603:10b6:5:24d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Mon, 5 Oct
 2020 12:58:09 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2%4]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 12:58:09 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mgross@linux.intel.com>
CC:     Mark Pearson <mpearson@lenovo.com>,
        Elia Devito <eliadevito@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Berg <bberg@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Pearson <markpearson@lenovo.com>
Subject: RE: [RFC] Documentation: Add documentation for new
 performance_profile sysfs class
Thread-Topic: [RFC] Documentation: Add documentation for new
 performance_profile sysfs class
Thread-Index: AQHWmYfgDjG0YI7kc0C9HQeldGcjC6mI+DtA
Date:   Mon, 5 Oct 2020 12:58:09 +0000
Message-ID: <DM6PR19MB263669227D122BB7699951E6FA0C0@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <20201003131938.9426-1-hdegoede@redhat.com>
 <20201003131938.9426-2-hdegoede@redhat.com>
In-Reply-To: <20201003131938.9426-2-hdegoede@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-10-05T12:47:16.8631695Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=e687cf99-3878-4123-aca7-5eb6dc93f33c;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d67f8e65-2550-4fae-d18b-08d8692e4f9d
x-ms-traffictypediagnostic: DM6PR19MB4076:
x-microsoft-antispam-prvs: <DM6PR19MB40763551EA54EDEFBA109565FA0C0@DM6PR19MB4076.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l9GIcsgMXJOooYWIhdnE0/ZOGMy13bwzQVD25g7Kn38FyTinwA4UZ4PkTGCoy5Z5l9MXiKu66cV5fnt3KK4KTJlOA76qrHEafZGlSDafD5nNx3OkphMwgH6sFb3MpgUuErbjL6kvZzoKpOGrJbMC7Cw9LJ6gMjFbIaqN5qm7xAlJ/0ZgiKq3v0dB00MJBWwVFS+hOEWl5qTSMsih6yX/DvfHKWhtlUFplOyaLUB/hQXyPqOltEGxpv8IT7enK0NnBDN/mkSnSNYZibMHSRrjvYQ9xRaGW5KOHOeDz83T9iE0deG1+KXna1a5pLg5r6eac7dMau1Lq8qO9fSOsITqXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(366004)(396003)(39860400002)(7696005)(478600001)(786003)(316002)(71200400001)(4326008)(86362001)(110136005)(6506007)(54906003)(66946007)(66446008)(64756008)(66556008)(66476007)(186003)(9686003)(76116006)(8676002)(7416002)(26005)(2906002)(33656002)(8936002)(5660300002)(55016002)(83380400001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: xBnIKaieGqAnECTW2ijWz19guqf2e1qX+is/hmC3Tpe7qB911TBMRdNEedg1eYcxjDaST9YA7SELhdAKapBRnxGaS/SY6D58/nLOJ1oTivCpg32iOqdbypvhE2nvg2Wg81OYxsfBXoBqerS4PCFXSklKBV6nMzHMo0O74fCDRO6KDOAmPMuPvssV9vqIuMEOeluX7frZMJ4a8b7r/oZ3m9fv6CLmwUf+whc2iJiiC3XfiDOOVNhvwdwNW43X5NweKmOitkZvJDQv4j4BjlgxtvLkL326jugZwoFXQRMDC8sxuxc91GR0dTihC4pUaCa2BMXM5UIETtRWGuvfa6DxQBoUOd17HFk4TPaoLiK6n3KLJqAeLpfLvYB7t8W2xDHY/u2susS0A6Bgu0k7TgPK1HxXSBIVrf3IuP0bpDaH6SnkzdcWpkSCTDoPl/8XlIDB5dv6+6TFSZtYLexco6YgRmVaQOIRZEJOK/CmKRbV8u0YsE8XXmvnIm6+q564eXOZ3haUR0occKQwnb6f96l45YUk1Y0PU2bCUiJXN/mf/gxjWxt8dZtw5v9WhWWZx0PlGSE6ROJUGzy+2sU4Iwqkm4xwZooPzU6EMNYCbc8IaBjQI2H2dOH5/NBIgzECajMJim28diNVobHuj/qxZtGcGA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d67f8e65-2550-4fae-d18b-08d8692e4f9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2020 12:58:09.6501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bmDQlpxac7Mwz2RSVVZzCeBmPuth3NHLfQDKS7Gbyz7lOIcDYVqe1ir01By05Sxr0Wymagr1hKaFEwaRZ+ITIvTtFmxpvv5XrK5TtgTkYTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4076
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_07:2020-10-02,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010050096
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010050096
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> On modern systems CPU/GPU/... performance is often dynamically configurab=
le
> in the form of e.g. variable clock-speeds and TPD. The performance is oft=
en
> automatically adjusted to the load by some automatic-mechanism (which may
> very well live outside the kernel).
>=20
> These auto performance-adjustment mechanisms often can be configured with
> one of several performance-profiles, with either a bias towards low-power
> consumption (and cool and quiet) or towards performance (and higher power
> consumption and thermals).
>=20
> Introduce a new performance_profile class/sysfs API which offers a generi=
c
> API for selecting the performance-profile of these automatic-mechanisms.
>=20

If introducing an API for this - let me ask the question, why even let each
driver offer a class interface and userspace need to change "each" driver's
performance setting?

I would think that you could just offer something kernel-wide like
/sys/power/performance-profile

Userspace can read and write to a single file.  All drivers can get notifie=
d
on this sysfs file changing.

The systems that react in firmware (such as the two that prompted
this discussion) can change at that time.  It leaves the possibility for a
more open kernel implementation that can do the same thing though too by
directly modifying device registers instead of ACPI devices.

> Cc: Mark Pearson <markpearson@lenovo.com>
> Cc: Elia Devito <eliadevito@gmail.com>
> Cc: Bastien Nocera <hadess@hadess.net>
> Cc: Benjamin Berg <bberg@redhat.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../testing/sysfs-class-performance_profile   | 104 ++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-performance_pro=
file
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-performance_profile
> b/Documentation/ABI/testing/sysfs-class-performance_profile
> new file mode 100644
> index 000000000000..9c67cae39600
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-performance_profile
> @@ -0,0 +1,104 @@
> +Performance-profile selection (e.g.
> /sys/class/performance_profile/thinkpad_acpi/)
> +
> +On modern systems CPU/GPU/... performance is often dynamically configura=
ble
> +in the form of e.g. variable clock-speeds and TPD. The performance is of=
ten
> +automatically adjusted to the load by some automatic-mechanism (which ma=
y
> +very well live outside the kernel).

Are you intending to word this specifically to cover both firmware and user=
space
implementations?  Or were you really meaning firmware implementations?

> +
> +These auto performance-adjustment mechanisms often can be configured wit=
h
> +one of several performance-profiles, with either a bias towards low-powe=
r
> +consumption (and cool and quiet) or towards performance (and higher powe=
r
> +consumption and thermals).
> +
> +The purpose of the performance_profile class is to offer a generic sysfs
> +API for selecting the performance-profile of these automatic-mechanisms.
> +
> +Note that this API is only for selecting the performance-profile, it is
> +NOT a goal of this API to allow monitoring the resulting performance
> +characteristics. Monitoring performance is best done with device/vendor
> +specific tools such as e.g. turbostat.

Another thought that comes to mind (which is completely separate from my pr=
evious
idea):

Why not make this register to firmware-attributes class as being discussed =
in the
new Dell driver?

It seems like it could easily be read as:
/sys/class/firmware-attributes/thinkpad-foo/attributes/PerformanceProfile/c=
urrent_value
/sys/class/firmware-attributes/thinkpad-foo/attributes/PerformanceProfile/p=
ossible_values


> +
> +Specifically when selecting a high-performance profile the actual achiev=
ed
> +performance may be limited by various factors such as: the heat generate=
d by
> +other components, room temperature, free air flow at the bottom of a lap=
top,
> +etc. It is explicitly NOT a goal of this API to let userspace know about
> +any sub-optimal conditions which are impeding reaching the requested
> +performance level.
> +
> +Since numbers are a rather meaningless way to describe performance-profi=
les
> +this API uses strings to describe the various profiles. To make sure tha=
t
> +userspace gets a consistent experience when using this API this API docu=
ment
> +defines a fixed set of profile-names. Drivers *must* map their internal
> +profile representation/names onto this fixed set.
> +
> +If for some reason there is no good match when mapping then a new profil=
e-name
> +may be added. Drivers which wish to introduce new profile-names must:
> +1. Have very good reasons to do so.
> +2. Add the new profile-name to this document, so that future drivers whi=
ch also
> +   have a similar problem can use the same new. Usually new profile-name=
s will
> +   be added to the "extra profile-names" section of this document. But i=
n some
> +   cases the set of standard profile-names may be extended.
> +
> +What:		/sys/class/performance_profile/<device>/available_profiles
> +Date:		October 2020
> +Contact:	Hans de Goede <hdegoede@redhat.com>
> +Description:
> +		Reading this file gives a space separated list of profiles
> +		supported for this device.
> +
> +		Drivers must use the following standard profile-names whenever
> +		possible:
> +
> +		low-power:		Emphasises low power consumption
> +					(and also cool and quiet)
> +		balanced-low-power:	Balances between low power consumption
> +					and performance with a slight bias
> +					towards low power
> +		balanced:		Balance between low power consumption
> +					and performance
> +		balanced-performance:	Balances between performance and low
> +					power consumption with a slight bias
> +					towards performance
> +		performance:		Emphasises performance (and may lead to
> +					higher temperatures and fan speeds)
> +
> +		Userspace may expect drivers to offer at least several of these
> +		standard profile-names! If none of the above are a good match
> +		for some of the drivers profiles, then drivers may use one of
> +		these extra profile-names:
> +		<reserved for future use>
> +
> +What:		/sys/class/performance_profile/<device>/current_profile
> +Date:		October 2020
> +Contact:	Hans de Goede <hdegoede@redhat.com>
> +Description:
> +		Reading this file gives the current selected profile for this
> +		device. Writing this file with one of the strings from
> +		available_profiles changes the profile to the new value.
> +
> +		Reading this file may also return "custom". This is intended for
> +		drivers which have and export multiple knobs influencing
> +		performance. Such drivers may very well still want to offer a
> +		set of profiles for easy of use and to be able to offer a
> +		consistent standard API (this API) to userspace for configuring
> +		their performance. The "custom" value is intended for when a
> +		user has directly configured the knobs (through e.g. some
> +		advanced control-panel for a GPU) and the knob values do not
> +		match any of the presets represented by the
> +		performance-profiles. In this case writing this file will
> +		override the modifications and restore the selected presets.
> +
> +What:		/sys/class/performance_profile/<device>/type
> +Date:		October 2020
> +Contact:	Hans de Goede <hdegoede@redhat.com>
> +Description:
> +		Performance-profiles may be system-wide, or for a specific
> +		device (e.g. CPU / GPU). System-wide profiles are typically
> +		used on devices where where a single cooling solution is
> +		shared between all components, such as laptops and NUCs.
> +
> +		Reading this file indicates the type of the device for which
> +		the thermal-profile is being configured.
> +
> +		Valid values: "system"
> +		Reserved for future use values: "cpu", "gpu"
> --
> 2.28.0

