Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B8634681E
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Mar 2021 19:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhCWSwN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Mar 2021 14:52:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:40682 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232203AbhCWSvr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Mar 2021 14:51:47 -0400
IronPort-SDR: 4r4btpe6doyS3SbNyuEfFgOGkP8Cia/tg12Msb99jAhXZqqP+upr47yU8mSTCVezilj60kFYaS
 76ccsQAFIHMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="190642859"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="190642859"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 11:51:47 -0700
IronPort-SDR: rh+1EMpBGkSxFwBBZl63kWwur9oYWtES4oj25lKtQNC9r7cFs7dVoGD97FW9Gz7mXzIiRx8hvE
 tTuyGoMLhtEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="390997907"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga002.jf.intel.com with ESMTP; 23 Mar 2021 11:51:46 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 11:51:45 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 11:51:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 23 Mar 2021 11:51:45 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 23 Mar 2021 11:51:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/1lO846LgXZtXyqWggg4IwpgPTf/TKuQEv/7gvZii3mt7lR04AH63qwy/+OCxHfvldVk1LIcFSjwAE6E0Vt10GzoSugmHlPBBcejAECUfgvAGb3Oeb52AX5TyyCTYIVSHEtodQy0cOzsCs5wNX9099bw+UHzLpHMKtWZa69hQx/aYuqI6OuSxERtZEZfJiZNmdqowQ0VJ4WZdO5NDuO5pgi/O2G3C0/Adav/4VsZAStPXQSP+lJM3Z88jKGyXRr0/q7IfPQxHjciX7zc1kHNlO2Gh5JrfroYX9uz+MkdnffUv94HVzgCFoSXuDweAUeXUaoQ01cIpDNRs5vMBtuWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIk0upg1yiUZR0NBgHdtjI2vNMSZMgR92DzFG89vJDU=;
 b=kl7RBhrNWdkBWABLsDV0HWoAGmYo5wza7UOl1m61Y+/VGyXFYB98+WL25SH7+k2oygWqtr7tqgeIYU5+vhBBqrQsCr3MClBQjwA7PzgmCSThl33FfA0RK4CHieOL3uUZV5NpAgBjFc9ceie3ux9orhFoHFOIUkRdF472x/GfL/BIJseGbdDMGryePITbVIYmRxI5V0ZjY0PH4QWZUgCpqwVvbQyGPlEaSx+Qn47FevBPkDGKDi0vxOCDp+jfYULOGPNi/f0J1uP7OzVVn5E6ZDeOrr+LG+HOel5AShobI7u3zsE4ECjfMhMB4B69aNeUM47C5GAE8kLVNwneio+rSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIk0upg1yiUZR0NBgHdtjI2vNMSZMgR92DzFG89vJDU=;
 b=t6fYMtVQY28fc3NN/d3jlMXNOKupXLzdK5pDYlnz3XH/VoxCIZNH65/XxXoS30Yrz5b4Znsfv81qd4s8wKPdiGgpWvMxCrmoYENMI13Md7v/F0nYUIuOkjXkJ5LS+/6gVn5/7M/Aj4lIfOEZjtx6mdcomL9QEJja89oC+FH5gmM=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by MW3PR11MB4746.namprd11.prod.outlook.com (2603:10b6:303:5f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 18:51:44 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::b874:3c43:9abe:d35e]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::b874:3c43:9abe:d35e%5]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 18:51:44 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>
Subject: RE: [RFC PATCH v2 1/8] ACPICA: IORT: Update for revision E
Thread-Topic: [RFC PATCH v2 1/8] ACPICA: IORT: Update for revision E
Thread-Index: AQHXHwc4z+izlmn+GkWYqA4mAb6Fp6qQh6KggAEzrQCAACgMYA==
Date:   Tue, 23 Mar 2021 18:51:44 +0000
Message-ID: <MWHPR11MB1599F9CAF0D21030619B359BF0649@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
 <20201119121150.3316-2-shameerali.kolothum.thodi@huawei.com>
 <b7a2424941214b33803e34ba3e532440@huawei.com>
 <MWHPR11MB1599238526CF0529394CD9D7F0659@MWHPR11MB1599.namprd11.prod.outlook.com>
 <20210323155336.GA1639@e121166-lin.cambridge.arm.com>
In-Reply-To: <20210323155336.GA1639@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [174.25.99.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df106404-8555-4f25-380b-08d8ee2cb472
x-ms-traffictypediagnostic: MW3PR11MB4746:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4746FCE8EEBF29E5DD9131CCF0649@MW3PR11MB4746.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CbJr8lgFmVOF2l9AG0QVOO0LHEnEWsfXBa8/6QPJfXx2e7JU+StHRhT6kGtjtUMLRXCZDTknZopsjrPvgTPvmuvJsiDJgqszKF4YO3Ex/1kUUS3L7nL4FS6WLiqe249+x8wHzWm+4OFdqvGPfK4SiosVezAtLrYdmOcDdRfWto7Gd38phTaJIOT8Z/xhpm38uKfqJ15HSqZPdtjz/PPefZV6WM7MuMRQ8t7ZlM/CImzF9Hjfl+K7Woef9y3ZCjm7B3rBui6hhfpqVPvFQCtjsM6Ln7Vm3ZtYOAq9QsK9uEBRTmlKIvrxWQz7N49pAQGSV2ymquxDOfAVADRtSet+s5htVXxxDKOFJC4XeDmQ75KFHoI3Z+ymhK/WdCBMvE4t9IemriJeWehAapBQAlGDUVxxfqievxFOVbmlUbmLUx42ad+9TmXNkQSCbA13ie0a26sXqiSVWLog5NR5rtgA58M714gwYebmm5YR6CGkjTC1J6OzbW1iDBrSTVgE97nK19gF/qv3pC7v3GVVHcTFwtUir0fsEB90lumWg7kuPn6UpSnk8oLbvAt+iJZPuZ7K2FkQ54dK3AOBrnYjL9xt+zpAYeZ18tKju0uErIRSz9V5jmJVRrAR1R2wMyebtm6lUo4MvrBrUvt0ta0tC7Mz/tvMdxO+w7oxsOXqOPjANwQmubisbXsxAaWBjUUfVgz5NGbfeXFpyUeHu6xnWqEDENCKZJhiDvcLB+m3Apt9LvGmYbsUA8ewVqBTiK+GI5z3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(39860400002)(346002)(396003)(7696005)(55016002)(33656002)(5660300002)(52536014)(8936002)(8676002)(4326008)(64756008)(38100700001)(6916009)(7416002)(478600001)(66556008)(71200400001)(84040400003)(66946007)(66476007)(76116006)(86362001)(26005)(15650500001)(966005)(186003)(2906002)(83380400001)(6506007)(53546011)(66446008)(316002)(54906003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?XDblSa6R8M3kJgU+bQ5yg7s5Nm03j14vP9tglrDCp5liVAsrDWZkp7xOvv?=
 =?iso-8859-1?Q?rtr+FPWB0Vom/paSK/MJagt53agbCqPx31/0LLFOFLBHjlqFFIh6Nxubln?=
 =?iso-8859-1?Q?ReNLCeQukmmUMiZYaupPuffOTRWbJLxIYuT67g8/LcrDYmIkT7b2o4Hz3e?=
 =?iso-8859-1?Q?ggr8GBt0vBCqwxFsLmNKBPqWctr1b5JRvjgMTaiLaRKzgLwGXpU3MSS40j?=
 =?iso-8859-1?Q?nWeiOGSfGiuQ87Tabee9/ZchpeUCSgr/GXWNGxVW3zvvppBOOkgAS6U00s?=
 =?iso-8859-1?Q?YQnsbwvFCbBA2Wf5APZAboWmz707JNaUpIve6t5gtyiFx9hAH3T33rYboM?=
 =?iso-8859-1?Q?PmtaguuMowuRE885ReH//+J5gThe0x3Midk+8o7daZX/PaoF9jomUoVTg+?=
 =?iso-8859-1?Q?+1NMsZawLWPnVX/qizqmBxVvw9oOEgyWQw43DmNc/WNMHRrjGCE7GnDVgD?=
 =?iso-8859-1?Q?XHkDNUHrvyc4JofWLKZddkh1W+2EI373csHAeXAG49XilSKsKJjtW/CwCN?=
 =?iso-8859-1?Q?GU4C6kcPWQjiw2J37VtTEGLiV2WwnEJY5AIlsVnAeh8TnUDpJOfi7FXfCE?=
 =?iso-8859-1?Q?047nqUSRZ25D5FZXK6sTTvvJ77XtnrRYArJTzZiGCvVvMqI54T1oLXxP3a?=
 =?iso-8859-1?Q?gyc4UmggkWal3FwuT192hfWZCfVE/ixeKS+YN3eTX+lTUcde0OTbgDNgLr?=
 =?iso-8859-1?Q?y9dzwZdY/7c4mKKbmCMH8OWhhlOA3e4DaKfQlYcQ6enJBLv45hgdDYJOO7?=
 =?iso-8859-1?Q?6gNc2IHL+xsMCT7LJxwgxqlNimN9bgImNZhccviVEnOQwTahjjs3kiok7B?=
 =?iso-8859-1?Q?gM8LLgR1sea2kzbahHYrm2lpOihwzoFlV/8rpG5AB+rkY2gsN5AX7mj5Hw?=
 =?iso-8859-1?Q?18SD1Cvmy51JzvNUECxNLBlTPaIoK59Ue6KMFSBSuLrWsovSHHBJk064fh?=
 =?iso-8859-1?Q?kSSb3FehVoswj3Dc0/2uURqznwWpbeATPdF5SaNPc2RTiSgnXMtH6aev/5?=
 =?iso-8859-1?Q?WBdYO5y+rqRzQ/s4uAZS3zMboHMjY0fN+0hu/o41t09CRhs09l6lS4bjA6?=
 =?iso-8859-1?Q?YO0L+uGQKVG1F1pjkM4Rmuk3VxM9HhLaqWrS88UBfv9WhrOkUhmxp3Zg6+?=
 =?iso-8859-1?Q?NGdKO8ODwhJatl82UGMfp3AgF9b3LubcmWBYYZQMaVTsjX8BrKEI4dbxjm?=
 =?iso-8859-1?Q?cqoXsPDoQIN8Ec/imbOD4vGOsH+d9D8JJeY2gcx3pLAUxnriNoFG0zoJhA?=
 =?iso-8859-1?Q?5d83/Z4OGDtUqGCj/1Uh9g/o8xXRfxYeG5AP7sBbhZrEtCEepHp5qVntVm?=
 =?iso-8859-1?Q?Ab7VfrkzcmgtqwTGNzwi7Qt0PFdT8CaarpSgG84+THqzkfU37stcsRDDqu?=
 =?iso-8859-1?Q?iX7djpQMJn?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df106404-8555-4f25-380b-08d8ee2cb472
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 18:51:44.5001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WInMv7TM1yF0L69mSFBnt/cfkQrkT3IQMc0mV1FmGGsEhinP5mnjrOp/3Fz6XHa9pxzlkB+J2ASkvQtqqcczrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4746
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Tuesday, March 23, 2021 8:54 AM
> To: Kaneda, Erik <erik.kaneda@intel.com>
> Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> iommu@lists.linux-foundation.org; devel@acpica.org; Moore, Robert
> <robert.moore@intel.com>; Linuxarm <linuxarm@huawei.com>;
> steven.price@arm.com; Sami.Mujawar@arm.com; robin.murphy@arm.com;
> wanghuiqiang <wanghuiqiang@huawei.com>
> Subject: Re: [RFC PATCH v2 1/8] ACPICA: IORT: Update for revision E
>=20
> On Mon, Mar 22, 2021 at 09:57:58PM +0000, Kaneda, Erik wrote:
> >
> >
> > > -----Original Message-----
> > > From: Shameerali Kolothum Thodi
> > > <shameerali.kolothum.thodi@huawei.com>
> > > Sent: Monday, March 22, 2021 3:36 AM
> > > To: Kaneda, Erik <erik.kaneda@intel.com>; linux-arm-
> > > kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> iommu@lists.linux-
> > > foundation.org; devel@acpica.org; Lorenzo Pieralisi
> > > <lorenzo.pieralisi@arm.com>; Moore, Robert
> <robert.moore@intel.com>
> > > Cc: Linuxarm <linuxarm@huawei.com>; steven.price@arm.com;
> > > Sami.Mujawar@arm.com; robin.murphy@arm.com; wanghuiqiang
> > > <wanghuiqiang@huawei.com>
> > > Subject: [Devel] Re: [RFC PATCH v2 1/8] ACPICA: IORT: Update for
> revision E
> > >
> > > [+]
> > >
> > > Hi Erik,
> > >
> > > As this is now just merged ino acpica-master and based on the discuss=
ion
> we
> > > had here,
> > >
> > > https://github.com/acpica/acpica/pull/638
> > >
> > > I had a discussion with ARM folks(Lorenzo) in the linaro-open-discuss=
ions
> call
> > > and
> > > can confirm that the IORT Revision E is not the final specification a=
nd has
> > > some issues
> > > which is now corrected in the latest E.b revision[1]. Also there are =
no
> current
> > > users
> > > for the Rev E and it may not be a good idea to push this version into=
 the
> Linux
> > > kernel
> > > or elsewhere.
> > >
> > > So could you please revert the merge and I am planning to work on the
> E.b
> > > soon.
> > Hi,
> >
> > > Please let me know if I need to explicitly send a revert pull request=
 or not.
> >
> > Please send a revert pull request and I'll remember to not submit Linux=
-ize
> the IORT patches.
> >
> > From all of the activity that I've seen with the IORT specification,
> > it looks like this table is nontrivial to design and maintain. The
> > difficulty I have with the table is that I do not understand which
> > table revisions are in active use.
>=20
Hi Lorenzo,

> Possibly all of them in firmware in the field - I am not sure what you
> are asking though; if you can elaborate I'd be grateful.

Yes, I'd be happy to explain.

The ACPICA project contains code that provides definitions for ACPI tables.=
 After each release of this project, the codebase gets translated to a Linu=
x style syntax and relevant patches are submitted to Linux so that it can u=
se these table definitions in their driver codebase. From ACPICA's perspect=
ive, the code providing these definitions are used to implement a compiler/=
disassembler called iASL. This tool disassembles table definitions so that =
the user doesn't have to open a hex editor to decipher ACPI tables. Our goa=
l with iASL is to be able to disassemble as many ACPI tables as possible to=
 give users the ability to compile and debug ACPI tables.

Out of the 60+ tables that we support, IORT has been tricky to maintain. Th=
ere are revisions A-E and we have received pull requests from engineers fro=
m ARM or companies that work with ARM. We are grateful of their contributio=
ns but some of these pull requests have broken support for earlier versions=
 of IORT. In addition, we sometimes receive communication from people like =
Shameer saying that revision E does not currently have users. This leaves B=
ob and I very confused about which revisions we should be focused on suppor=
ting in iASL.

We need your help in understanding which versions of IORT should be support=
ed by iASL as well as Linux.

I hope this helps.. Let me know if you need me to clarify anything that I'v=
e written.

Thanks,
Erik
>=20
> > So my question is this: which IORT revisions are being actively used?
>=20
> See above.
>=20
> Thanks,
> Lorenzo
>=20
> >
> > Thanks,
> > Erik
> > >
> > > Thanks,
> > > Shameer
> > >
> > > 1. https://developer.arm.com/documentation/den0049/latest/
> > >
> > > > -----Original Message-----
> > > > From: iommu [mailto:iommu-bounces@lists.linux-foundation.org] On
> > > Behalf Of
> > > > Shameer Kolothum
> > > > Sent: 19 November 2020 12:12
> > > > To: linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.or=
g;
> > > > iommu@lists.linux-foundation.org; devel@acpica.org
> > > > Cc: Linuxarm <linuxarm@huawei.com>; steven.price@arm.com;
> > > Guohanjun
> > > > (Hanjun Guo) <guohanjun@huawei.com>; Sami.Mujawar@arm.com;
> > > > robin.murphy@arm.com; wanghuiqiang <wanghuiqiang@huawei.com>
> > > > Subject: [RFC PATCH v2 1/8] ACPICA: IORT: Update for revision E
> > > >
> > > > IORT revision E contains a few additions like,
> > > > =A0 =A0 -Added an identifier field in the node descriptors to aid t=
able
> > > > =A0 =A0 =A0cross-referencing.
> > > > =A0 =A0 -Introduced the Reserved Memory Range(RMR) node. This is us=
ed
> > > >  =A0 =A0 to describe memory ranges that are used by endpoints and r=
equires
> > > >  =A0 =A0 a unity mapping in SMMU.
> > > >     -Introduced a flag in the RC node to express support for PRI.
> > > >
> > > > Signed-off-by: Shameer Kolothum
> > > <shameerali.kolothum.thodi@huawei.com>
> > > > ---
> > > >  include/acpi/actbl2.h | 25 +++++++++++++++++++------
> > > >  1 file changed, 19 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h index
> > > > ec66779cb193..274fce7b5c01 100644
> > > > --- a/include/acpi/actbl2.h
> > > > +++ b/include/acpi/actbl2.h
> > > > @@ -68,7 +68,7 @@
> > > >   * IORT - IO Remapping Table
> > > >   *
> > > >   * Conforms to "IO Remapping Table System Software on ARM
> Platforms",
> > > > - * Document number: ARM DEN 0049D, March 2018
> > > > + * Document number: ARM DEN 0049E, June 2020
> > > >   *
> > > >
> > > >
> > >
> **********************************************************
> > > ******
> > > > **************/
> > > >
> > > > @@ -86,7 +86,8 @@ struct acpi_iort_node {
> > > >  	u8 type;
> > > >  	u16 length;
> > > >  	u8 revision;
> > > > -	u32 reserved;
> > > > +	u16 reserved;
> > > > +	u16 identifier;
> > > >  	u32 mapping_count;
> > > >  	u32 mapping_offset;
> > > >  	char node_data[1];
> > > > @@ -100,7 +101,8 @@ enum acpi_iort_node_type {
> > > >  	ACPI_IORT_NODE_PCI_ROOT_COMPLEX =3D 0x02,
> > > >  	ACPI_IORT_NODE_SMMU =3D 0x03,
> > > >  	ACPI_IORT_NODE_SMMU_V3 =3D 0x04,
> > > > -	ACPI_IORT_NODE_PMCG =3D 0x05
> > > > +	ACPI_IORT_NODE_PMCG =3D 0x05,
> > > > +	ACPI_IORT_NODE_RMR =3D 0x06,
> > > >  };
> > > >
> > > >  struct acpi_iort_id_mapping {
> > > > @@ -167,10 +169,10 @@ struct acpi_iort_root_complex {
> > > >  	u8 reserved[3];		/* Reserved, must be zero */
> > > >  };
> > > >
> > > > -/* Values for ats_attribute field above */
> > > > +/* Masks for ats_attribute field above */
> > > >
> > > > -#define ACPI_IORT_ATS_SUPPORTED         0x00000001	/* The root
> > > > complex supports ATS */
> > > > -#define ACPI_IORT_ATS_UNSUPPORTED       0x00000000	/* The root
> > > > complex doesn't support ATS */
> > > > +#define ACPI_IORT_ATS_SUPPORTED         (1)	/* The root complex
> > > > supports ATS */
> > > > +#define ACPI_IORT_PRI_SUPPORTED         (1<<1)	/* The root
> complex
> > > > supports PRI */
> > > >
> > > >  struct acpi_iort_smmu {
> > > >  	u64 base_address;	/* SMMU base address */
> > > > @@ -241,6 +243,17 @@ struct acpi_iort_pmcg {
> > > >  	u64 page1_base_address;
> > > >  };
> > > >
> > > > +struct acpi_iort_rmr {
> > > > +	u32 rmr_count;
> > > > +	u32 rmr_offset;
> > > > +};
> > > > +
> > > > +struct acpi_iort_rmr_desc {
> > > > +	u64 base_address;
> > > > +	u64 length;
> > > > +	u32 reserved;
> > > > +};
> > > > +
> > > >
> > > >
> > >
> /**********************************************************
> > > *****
> > > > ****************
> > > >   *
> > > >   * IVRS - I/O Virtualization Reporting Structure
> > > > --
> > > > 2.17.1
> > > >
> > > > _______________________________________________
> > > > iommu mailing list
> > > > iommu@lists.linux-foundation.org
> > > > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> > > _______________________________________________
> > > Devel mailing list -- devel@acpica.org
> > > To unsubscribe send an email to devel-leave@acpica.org
> > > %(web_page_url)slistinfo%(cgiext)s/%(_internal_name)s
