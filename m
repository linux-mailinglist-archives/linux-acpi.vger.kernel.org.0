Return-Path: <linux-acpi+bounces-3554-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C268C856AE4
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 18:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21F31C23C37
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 17:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD5C136672;
	Thu, 15 Feb 2024 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jUKgoHeF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EF11339B2;
	Thu, 15 Feb 2024 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017837; cv=fail; b=MrdiLzUwPwDDlNpUEpWDU4F/fjU3v+SzztbeVebBndspxegHXrEiNVcyMvgOTrQPNKGu38AT3BuzmAlJ/AUNqNVOF8isfEaPm8MAmEvomlUflzGHgPbUw4iUT7TC1wmNKQ/uqW4/wWjFor9uFQucjVZqplVF6xFXtUAaCY8DELM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017837; c=relaxed/simple;
	bh=yp/Q6dgj29/m3qxVXzdW/gOyilpMr8hZJE3HBZW53lA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=apUPc/YigjunEmcqsCXrecI+vb26Z5XhwvgrduHHO5ET/4t4IJBQub4AFKIO+uN6jWdFTQf/l9on4uDyqtrswy43pX+4AME92CQ8LuL5SHlS4N4KGebwOpMx8XhRbHOpzXZKuwU1h0DHRWkBlgxNFV292TN4lVQHccL/cGMSVcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jUKgoHeF; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708017835; x=1739553835;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yp/Q6dgj29/m3qxVXzdW/gOyilpMr8hZJE3HBZW53lA=;
  b=jUKgoHeFr2KVcMZjK06zK7VaJDGoF9KOVegSia9f5Iuf9h08ZGhqixmy
   uR8ruBmM9WjeCiPTh87lvN/WLf3+iG6/hTVdvgNCajt74FlMct6fgWPQd
   ncvlsYHhCkfSSXgX3P4UAKQS53bmCE3NtET2gTI5G00kxHRfd+V8uqJNM
   sLNBI+5zZQylwdVHagDdv++i9GbcCzVdszOGyOxhlNFPrm0pRABE6gMSy
   3hHb2cRTgjpd6C85OsmRD5GIQakv+T1ucV0UIWD3uDtEAxhFNdmI2QCpp
   Dk+dc6TV9HliUuijYurWSpZDMbXFdvYHlKoXLPJkvkCxTaomSX6YjxX03
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="12747567"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="12747567"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 09:23:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="41087700"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Feb 2024 09:23:32 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 09:23:31 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 09:23:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 15 Feb 2024 09:23:30 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Feb 2024 09:23:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3Hoc2ostnU/DNISfbVsSwyy10K1Fu7y9AoQ5dySiwKJltHTeEvr1XgN41Be4Klzom9m/L9iLizi+wtnceHOGUs67jiFtcqot7krQomYaRqTa89XSC8+Ur4+bqbXV1pu2e/Jk1Y69xkPJ6KPegodnGth3FyX8aN2pdrLgSaOba3uXxWjlzxQSTrTYznmmtszQDGowdgyvkhPlTcwxlcGzeVeKRcL6Q/e8ezzu7rJna2p2dfOxepUDuvhjzl/kf2ws9ABA4A+jfpb5u5l9wJrFtLQw4+4Imb31+MSeZ6CMffqxvETW5QBEieuedGUAL3j0wLK/N+kAElbTHItqAGSeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJzz1JgGiKpml6eVOg0J48i0vWQEQKQOkyGNiwW3pVo=;
 b=W+TjjwXNmBqXlxD8pAVb7hZWVmhiKAdhG1qLG2uZyLvCXGrzlw39acmr7EpUP7t6s+wSLgUNWV2Ou9lNjDt4SQHgdyO0MeQC/Z0L1fmlU9uxVOvElLfecvNYdXbGHxyZefDep1zWlU86eocYMpEW1NlLCuEwIQ0Uhyj6EZ6V/GCGy7QFaYVipkjRsTQJ+dMI6RuxW5qhL80ava3q43T49ZI4dap2mhA8Hnt2Tohn4IngjlZmVsJjh4xEkmUqK8VFslZSPlegCkmIESo5+dLdXmYQj2GF3d2PDeGeptxRDJf1PhMCblmBgxLsa2MHtysZh+3EhQgCw956WRVxmLeRZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB5229.namprd11.prod.outlook.com (2603:10b6:5:39f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 15 Feb
 2024 17:23:28 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802%3]) with mapi id 15.20.7292.027; Thu, 15 Feb 2024
 17:23:26 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, Ben Cheatham
	<Benjamin.Cheatham@amd.com>
CC: "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "james.morse@arm.com"
	<james.morse@arm.com>, "bp@alien8.de" <bp@alien8.de>, "dave@stogolabs.net"
	<dave@stogolabs.net>, "Jiang, Dave" <dave.jiang@intel.com>, "Schofield,
 Alison" <alison.schofield@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v12 0/3] cxl, EINJ: Update EINJ for CXL error types
Thread-Topic: [PATCH v12 0/3] cxl, EINJ: Update EINJ for CXL error types
Thread-Index: AQHaX4F7SfMply+qm0W3UknoqcSar7EKtVW6gADvtqA=
Date: Thu, 15 Feb 2024 17:23:26 +0000
Message-ID: <SJ1PR11MB60832AFF7D2F9FBD2670CBBEFC4D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240214200709.777166-1-Benjamin.Cheatham@amd.com>
 <Zc1kwWupeN9WagFj@agluck-desk3>
 <65cd7cac71377_5c76294ad@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To: <65cd7cac71377_5c76294ad@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB5229:EE_
x-ms-office365-filtering-correlation-id: 47493903-fb75-417c-ab75-08dc2e4ad210
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dBC3xSaN/Sp0xoSI+a3132Zn4YaAI/tt32GJkhMUrkShIFNCKhMdXHERj4P2/CDxgyvE6AsvpHycSPcT4qJTVFuncvwtEKAIZ/tt5DtYSlQAkI4h/khRNDNWZhoaapn/KT/JIRIWc4Si1CQoqugW0+PJW4hCW67TD85ADzKZ48DeQDv62UYRm0ddROH3n997zxnK7Q9SoDp4t9rqyU21tHW0xJpaqdNKu1Hq4i1LmfjUsKIVhDtuZ83FgPvO+U/3y+0N4YOUNVi57n10Spb9NmnXmoCc6F3nSfLNHFYSThLijqwl6U4V3VMent9CA4ZbJGj6KBq1x6fRqJkBLbJuYuS+APV0ZAwp2c5TsTwBRY9Ow3AqzKwKAWKrsaKXiZAVBL1lLhhuaO2fsDC1tGIxf8wSC2iTjURD9Tm32mO0rI9y6BeCyEyPP2iAV8t3cGODr9u/j29oK11Ccv8xkHXK15sw2RmXgpDY+YwQ30qTBDOmrOvHgWmS2o7tZ60e88Lo3TyOmKdJQ6p1doQla7R0csWkvRkx8pbLgl4srO8wOo2voZJjwmRbeq6OlRij6T7HsfVMW74pGgxi1250guGwftpWzQuvFvfnijecQn1soHqmRFeAh45DNhAJSky3UR4/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(122000001)(33656002)(5660300002)(86362001)(2906002)(82960400001)(8676002)(64756008)(76116006)(52536014)(66556008)(66946007)(66446008)(8936002)(66476007)(4326008)(38100700002)(478600001)(26005)(41300700001)(38070700009)(71200400001)(54906003)(110136005)(316002)(9686003)(7696005)(6506007)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SEL9duuce3SUNeryDK7J1K2nasi1JEFhDFgEGfAGNgoW3w0uKGLPTbsgswDo?=
 =?us-ascii?Q?5tlJXVa2+oad7RjOWjZt7IpBEkHSuRjBNbbD43SNFHvZU0zEOQwpRMbdiA4z?=
 =?us-ascii?Q?s1CdX0l4wjO7HuwnORsWWwLlX4IK9iGImG9cxmS+QK/bT/nCKW/MiTaKI+SD?=
 =?us-ascii?Q?A3w2ts0Btx9EK3awEMdl75coCWVhSAP04sQ/AZ47ZUEo66Shb40ZNCU0Bcvi?=
 =?us-ascii?Q?70xtYK5kATPew2m1+rRXs8HB/+/+vNI9vxuCFZ0YfYc7NChCWLS0kAL/FpSA?=
 =?us-ascii?Q?S/pv7rZSMtKKpyKeru0U8FW4mmagCLkCjpwi0dAhzlUJIH4Vj1coW3Sse+U+?=
 =?us-ascii?Q?mv5pfKz4CB+wN1/SZNaqsHkugVbpi2PiEcLLkVL+uTWKw04gCA/AtReHp/RE?=
 =?us-ascii?Q?KP9kedaAzgFTvYWMMyYwk9xCs8ruJvUD+JpLhojgz5h86aFZfq0TnL/BCEsT?=
 =?us-ascii?Q?+XOVDYjTVuogbMtgQynR57XVIMNrMkume8kEFhKntRaleMVjrklQRMAltqRK?=
 =?us-ascii?Q?F3Ab9LMltGK3TCo2RyVBXvwQW+sCmgFWSa8ETyUZbG1fc4ocYpQzbmT6+g5O?=
 =?us-ascii?Q?z6UU4gdVoDKKtvd7DGLTBkohW/jgGyCpsyBZ4vXu9+mzqFZfyzEz7KywTNEJ?=
 =?us-ascii?Q?L84EcyjBQjFAbrsDWAyMpCmLz2iDr4+N7rkxElUND6JzAOBIeCXssCizsEnu?=
 =?us-ascii?Q?6PFqXj1toqsk4Rq/GFUawNjNwcVkwehFKJLQnFp9ygy/eHQGdTY+jLjG/jvQ?=
 =?us-ascii?Q?URlHCsdEBzhlGTA2JuW7aXBUAMJ8L/Q/xOGpE/BiXqm/C4sA75EF3Jl2SfnT?=
 =?us-ascii?Q?fTwjs+MY7lqc27ht9Sh30QwDk/Qth7cCkn03n+OoIXuOkk1wThrjbrNlyLh4?=
 =?us-ascii?Q?QMja1zHC0CK2fnDXTYES5DuJ10MboMnVkVwqzsGoVq0+A1Quic0kcwOL7V9h?=
 =?us-ascii?Q?TuWAMWl3mqw4DAVlLk7FmEL71M3S5aZXlp+xztJP3JfW7IgXoL/qgwTpY4cJ?=
 =?us-ascii?Q?JDzg16ORA1IqQZK+av6iHGyOVVlSzUltK6S7+eQj+LnELx2nhsRPAKh4nWI0?=
 =?us-ascii?Q?ISfqr2RBFU32VI9ia+tLaE7NT+/MUqoakIeUojrPsnmgPbPam0Z0zUeftnfM?=
 =?us-ascii?Q?kWIk4lI78yegDDbUObLst4zOWmI/bKgP5PkRQ7OQydk0vGwAc19KvoXf66r4?=
 =?us-ascii?Q?PVYER+7FzFVI7o80NZmpRPiDpJ7upzdvSj01CjNNWk2L1fnZ6ACozFoghBkD?=
 =?us-ascii?Q?GTX2gVmB4QsI0G3UQShMxUaxq3jTIOuFT3JpV4ps4wFvfBQK6KqxfoEqFXsP?=
 =?us-ascii?Q?mafBEcnt+DvYCLTV5Na3ZlkMFpFhkms9qkzBy8VGRlU77Ws5ee3WFuKN9ola?=
 =?us-ascii?Q?/qe0iDc/yfMoF6NgCo1OZJbNuWQiwKVEj8/YkdAg2C0r/G7GmGeQbqr2Tm3S?=
 =?us-ascii?Q?q4bYrr5B+Tq09w1YOiR91Az3Kdh2+5zGB0DN38cm/WSmSRlusMCH4I0rLFef?=
 =?us-ascii?Q?PjW2hUsb5Mc3rcPSHEnRXCGsjQqMSDr1XOTmZfaGp9nM/dXnn42Le/DfbdY4?=
 =?us-ascii?Q?5UarTeAeg0i/dUabsIRwsnZrQD61LgeVOmaIVAXO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47493903-fb75-417c-ab75-08dc2e4ad210
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 17:23:26.6092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 05C5OFphv1JlFSbokx9hGGXNLXk8YkjMznls9moi6yUq2Sw5VF+9Nh62oegElfEQzRBnQhGpQraYUWOyAfWiXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5229
X-OriginatorOrg: intel.com

> > Couple of oddities:
> >
> > 1) I built as a module (CONFIG_ACPI_APEI_EINJ=3Dm) like I normally do.
> >    But this was autoloaded and EINJ initialized during boot:
> >
> > [   33.909111] EINJ: Error INJection is initialized.
>
> In the current code it should only load if cxl_core.ko is also loaded.
>
> Can you share the output of lsmod to maybe see which module loaded that
> dependency?
>
> > I'm wondering if that might be a problem for anyone that likes to
> > leave the einj module not loaded until they have some need to
> > inject errors.
>
> That is a behavior change of this approach. Is it a problem?
>
> If it is I would say that we need to break out a new cxl_einj.ko module
> that when it loads walks the CXL topology and creates the debugfs files.
> Otherwise my assumption is that CONFIG_CXL_EINJ=3Dy means that cxl_core.k=
o
> loads einj.ko unconditionally.
>
> I would save that work for a clear description of why einj.ko should not
> be resident.

Personally, it would save me having to type "modprobe einj" to run tests (a=
nd
answer e-mails from validation folks telling they missed this step).

But others might feels this is unwanted. It looks like some distros build k=
ernels
with CONFIG_ACPI_APEI_EINJ=3Dm.

On the other hand, EINJ should be under control of a BIOS option that
defaults to "off". So production systems won't enable it.

But perhaps there will be a pr_warn() or pr_err() during boot. One of these=
 will likely trip:

	pr_warn("EINJ table not found.\n");
	pr_err("Failed to get EINJ table: %s\n", acpi_format_exception(status));
	pr_warn(FW_BUG "Invalid EINJ table.\n");
	pr_err("Error collecting EINJ resources.\n");

>
> > 2) Even though my system doesn't have any CXL support, I found this:
> >
> > # cat /sys/kernel/debug/cxl/einj_types
> > 0x00001000      CXL.cache Protocol Correctable
> >
> > What does this mean?
>
> Strange, does:
>
> /sys/kernel/debug/einj/available_error_type
>
> ...show the same even before these patches? I.e. maybe this pre-CXL BIOS =
was
> using the 0x1000 encoding when it should not?

I added a printk() to show the raw value returned by my BIOS: 0x80001038

So your guess is correct. By BIOS is setting 0x1000 bit when it shouldn't.
>
> > Using ras-tools I injected some DDR memory errors. So legacy
> > functionality still works OK.

-Tony

