Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D925F3169FA
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Feb 2021 16:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhBJPUP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Feb 2021 10:20:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:12337 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232012AbhBJPUJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Feb 2021 10:20:09 -0500
IronPort-SDR: xKg5gST/v/WBdIWShwL2y0KRHk3aLcFVZVmNOd1Iq+DvHJrGA0Yxf3XO3lDxsmLKD6Fu+WNITs
 74Q/BxoruQiQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="182228448"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="182228448"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 07:19:20 -0800
IronPort-SDR: xopni4GrZ0ZOgIXKYxk9r4sq98hb2fvJ3vu1fkNYn6eewWBoK4oQGh+y4IlbJMoMOP/mruQf/g
 TpVk7zYvPd9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="380172799"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 10 Feb 2021 07:19:20 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 10 Feb 2021 07:19:20 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 10 Feb 2021 07:19:20 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 10 Feb 2021 07:19:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fErEa7tyvsjoI2ejDK6RvnAOG1ra8i8JhLLkpbTxVFItV+XgrcGDvnr3qxdD492KE86ZGNfgCK+JoscMgUh71B/nri68R2Z4k60f6WByrFWDmrCpOqPFdSd/i0RpoAGjNX60WWEG6ZVm46Jl2t1qSAD3Q7VJGIQiHQa0vSPWZy0COvVowC+4ANJKkCqzANWQYnrOugfsJXzW1elbvBDw76Gk4uFNwwhNFXvQkbEJDJ17M2OksSMoLV3azRetXpoIn5HZNPW3q1hOhMKHT7stQik79734pEmtyq/IW3wS2AmyZkh3pKq0a/T4tY8mILrKDqA63W3HlZc/Misclx/H3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mkc0+ljhT2Jc2SyDaag81c5bPJhSVZjm0ChX6Bt5dYs=;
 b=M8zl+oE2tr1VlLRGmNl1qSUbntypLwqOPqL4tJtrs22Aid8fX3aoF577FkibbkbC3yhoRe0tyK+KYv9UHljG15M3zqav2orx64Mqx/4+j9cRQrlTuiXamL+dHEcUiVp0fX9M210tckhT5WIw5CfEnji1MRRBCxCDLxj+1JSib8jeb+1BFcsZPFrB76cM8mr/Rc1NJq/l26nxd8av1+D6vrh8CLsIaZPWfvNeein2SWjRQLqWzEBQxDboDBvCPy2akdtUHKL8m93Az8eZugHGHZ1JrAun/RgZGpEQyRXoWwm0xcaTJKpq5o848ydnS0Pd2mnv8GWZOuzqQywHh8+dRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mkc0+ljhT2Jc2SyDaag81c5bPJhSVZjm0ChX6Bt5dYs=;
 b=xb3uaAKHNRaCd+qr9Tw9raVQqoxEKjnAMwvPQx4d7ntVtv0CLBMkapJ7upPW//gZn43To6IG/Ob2AaTrpqboSH+1GG82r/nvOj3nL4U57UzvihumJfeNzt1BxNCiDobKYj0a/4e6jKjY+a+udJdn1Zn6OIb5cDSe4mTV56Lih/w=
Received: from BN6PR11MB1732.namprd11.prod.outlook.com (2603:10b6:404:102::7)
 by BN7PR11MB2739.namprd11.prod.outlook.com (2603:10b6:406:a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Wed, 10 Feb
 2021 15:18:38 +0000
Received: from BN6PR11MB1732.namprd11.prod.outlook.com
 ([fe80::b4a5:ccc6:a02d:ff93]) by BN6PR11MB1732.namprd11.prod.outlook.com
 ([fe80::b4a5:ccc6:a02d:ff93%8]) with mapi id 15.20.3846.026; Wed, 10 Feb 2021
 15:18:38 +0000
From:   "Natu, Mahesh" <mahesh.natu@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Douglas, Chet R" <chet.r.douglas@intel.com>,
        "Widawsky, Ben" <ben.widawsky@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>
Subject: RE: [RFC] ACPI Code First ECR: Generic Target
Thread-Topic: [RFC] ACPI Code First ECR: Generic Target
Thread-Index: AQHW/2CV8MYxCHenmEqoc630sTuQ+6pRP5AAgAA97zA=
Date:   Wed, 10 Feb 2021 15:18:38 +0000
Message-ID: <BN6PR11MB17324DD5B5E3B96BD022D8BBF58D9@BN6PR11MB1732.namprd11.prod.outlook.com>
References: <CAPcyv4gmd_cygXK0PpGkXmJLC3_ctEpRvpi5P-QcuXusFX5oNQ@mail.gmail.com>
 <20210210112330.00003e74@Huawei.com>
In-Reply-To: <20210210112330.00003e74@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: Huawei.com; dkim=none (message not signed)
 header.d=none;Huawei.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.164.224.106]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd1d59ef-4bef-477c-e9f3-08d8cdd7247e
x-ms-traffictypediagnostic: BN7PR11MB2739:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR11MB2739235F255C5E7DF5B9EEB1F58D9@BN7PR11MB2739.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bFAqBzyoGw8Wx2cBToxvARsjPZ2XksthXaZ7hUIRx404O54vtf/BmTXuV0QzoU7sAv3wlC3vy0Cx0FYbDJaz64qCJQHEGUM4vRKO56nBMjZuAt+M5zwJK/dlbwAmu8Noyj6esMHcfKlizk4bEEzKQ2J7TlhyiFAZwOLrrYPyqi+NedLns4wDrmWBewlkYEYa61OtOqyQZ8dP6VL28TRSk5Ta0BUkNqfUTl9seVeN8RKWysrwxgZJkpWVfoVdgoyYmgy7LWSLXi88YC/aj9k7F+rdkqGVliaRN9UYQbuchAyW9CixcnjhCHTwMUuBN77DtMgjgAbZy2tKnPTLy0/mtXtyD2RS3VyjAPHebQ3aMdfmd4L3eQmagkfpJ14p5Qcg4UnzlQ0zItvaFRpr1+LF0SSYK4fqFVkrwr71xaU7E0pSaW5O8Cl+EknmlwWs8tNuRUiriMFeX+ffLh/mXFvz2yBNQzOQTsZBv/AC2K8wtkZnp3Y9NgifpwppdSB3T1E5tiQmjUdCdgHO0gbYEP9GVIKoVQwbpLqaQqVa4Gsopo/IgGM2WCNZiUIj7yZbfPrBwewXoTom8qiVW6v01Vx00lpN5Y2gsBR6BT9wo6ON0SOmUGxRVT82Ag0KVKd1WoOvDDK7FFyjf5rX3ruIlD9kiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1732.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(39860400002)(136003)(396003)(71200400001)(4326008)(8676002)(2906002)(66446008)(64756008)(66556008)(54906003)(66476007)(52536014)(6506007)(53546011)(110136005)(33656002)(83380400001)(76116006)(6636002)(478600001)(7696005)(5660300002)(26005)(86362001)(8936002)(9686003)(66946007)(316002)(55016002)(966005)(186003)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5DptDdmcuYl5CvagyD7QBPw1VsJ6TlPKSusfLzKnP15leKs8zYsu1AKdGpqn?=
 =?us-ascii?Q?ItWZU1S/0Y+IbnzHvt59H4GVCwm0L9/IkGlXEwTnfCSkSErcjRW5P4TOA9Yy?=
 =?us-ascii?Q?oi4V/SLLwAsNJyG+anXyf7uTdiLJXVD1yozxOgy0tfFMCSKnPPEfOIr92ttr?=
 =?us-ascii?Q?yPpfWwgP0NyJXP0+jgVxtefRJpgF6CAm1XWLqlEZMmNVB+JZXZq/L27i/ZTS?=
 =?us-ascii?Q?L/oLY11lfMekwYnfPKRDmUgFVh7/nlW5mkbAmk1vX+Fxyx7Dfv5Z7qJIKBrI?=
 =?us-ascii?Q?s1MW0O5YfE9ET3ud2GCzK/t7m+PnqRSPI0nU8UQlObzhcS58/SpIfSKwPBm9?=
 =?us-ascii?Q?mzBsli9g7gsICTDFsZiNYRSexAwK+rT2/PXN2F5iEts9GvX92BT3LHLXwJLY?=
 =?us-ascii?Q?Gb2TcLO/SIeqXASsrdaJjUGFmIPnWoFtTwsFGsT/pIgFUTi6LtncQ4b1CZRc?=
 =?us-ascii?Q?x1kSYdlqAoTjUNuxVW6BJ3KOH3toasu8HUb7CidPUOT7ohCyOj8ahdvbFR+a?=
 =?us-ascii?Q?i8Gqo0TDGEqhUhjRGLuRkKDY+1wsg/Wg37qyVNJdwy5QQ6l58EAQai8/WvV8?=
 =?us-ascii?Q?pEAFm9rScaLt+gV8DHnXrHGkwhnRN4RHqCcAV3jzqlwl123NAtckssW5hPGR?=
 =?us-ascii?Q?5vMjShkrwaUykNQ5u/n7Rwzskp+boUFRCFdBTKiOPOJo88AYbCAsqaidpCxY?=
 =?us-ascii?Q?ZWKM5UPY5JziCYru33pg/4K508R+Lf/nkS9tmuttIRYOPk8R35wtd0vz+Ko/?=
 =?us-ascii?Q?CHpUuJ7Pwy/ySfka5/6lyZJtVV8TwA+rNiC8wR1yHbbEHO1O+yUUM3BSibGt?=
 =?us-ascii?Q?ntj6GvYSr7+TBRORoOEopMRkRrRUwfNzDhyBNso8DTsMPhzse16CFL5uu7SD?=
 =?us-ascii?Q?OG4GEHsp4+PnemMUG+ar3xBu+KZ4kweSur2XgEQyqMA5FV1HkTEQdIiWNReU?=
 =?us-ascii?Q?av1oflbdm5p0QZda6hZ09EqM46SZWQdSr2Fe3N6qbu58AEm1iuOi6xx9qpTs?=
 =?us-ascii?Q?l6l7HdZH8nmPXukC8fbcXoV4JtmSmCHhypsSB0BNnjB45opSXe4ik0/uV7H9?=
 =?us-ascii?Q?vRshj3E0Cmx5fGwDZQfIzqeTUklNXFTcIMqNq6xUV2oAIQjbQCckNtWECIjs?=
 =?us-ascii?Q?USN+CPyOwNJbO1Hl10J8fLkEXF1QbXoKM7YtH/S5Lx0mqZN7jJca1ZmnbIVh?=
 =?us-ascii?Q?FTeLFHkj7HX8xBXyUx3SUKI56efNcr/C/5hcxWxR3MOmsxj8VjfG+S2dFVzP?=
 =?us-ascii?Q?pUlxKaXZtgNlfuaPdsYE3VY15JIqSveQ53vclQ2beIgxNcE2mSVdVuJ7ke4d?=
 =?us-ascii?Q?GL1B+HaRXy7ONdP1qJZD1s2e?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1732.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1d59ef-4bef-477c-e9f3-08d8cdd7247e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 15:18:38.6285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u5xoso7r4m1Iny4vuKgLkwG5TO/k0QGbpfzgZgp7Ob6Nl7QvDLy4+LOsrcGTsZ0UWtb/o/YdieAO2tc7/x+Dfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2739
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jonathan,

First of all, it is a two-way problem because of the possibility of peer to=
 peer traffic between root ports.

CDAT works very well for enumerable components with clean boundaries. It wa=
s not designed to handle Root complex objects. For example, it would have t=
o account for CPU vendor specific coherent links between CPUs and at that p=
oint it starts looking like "HMAT".

Thank you,
Mahesh Natu
Datacenter Platform Architect
Intel Corporation

-----Original Message-----
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>=20
Sent: Wednesday, February 10, 2021 3:24 AM
To: Williams, Dan J <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org; Linux ACPI <linux-acpi@vger.kernel.org>; Nat=
u, Mahesh <mahesh.natu@intel.com>; Douglas, Chet R <chet.r.douglas@intel.co=
m>; Widawsky, Ben <ben.widawsky@intel.com>; Verma, Vishal L <vishal.l.verma=
@intel.com>
Subject: Re: [RFC] ACPI Code First ECR: Generic Target

On Tue, 9 Feb 2021 19:55:05 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> While the platform BIOS is able to describe the performance=20
> characteristics of CXL memory that is present at boot, it is unable to=20
> statically enumerate the performance of CXL memory hot inserted=20
> post-boot. The OS can enumerate most of the characteristics from link=20
> registers and CDAT, but the performance from the CPU to the host=20
> bridge, for example, is not enumerated by PCIE or CXL. Introduce an=20
> ACPI mechanism for this purpose. Critically this is achieved with a=20
> small tweak to how the existing Generic Initiator proximity domain is=20
> utilized in the HMAT.

Hi Dan,

Agree there is a hole here, but I think the proposed solution has some issu=
es for backwards compatibility.

Just to clarify, I believe CDAT from root ports is sufficient for the other=
 direction (GI on CXL, memory in host).  I wondered initially if this was a=
 two way issue, but after a reread, I think that is fine with the root port=
 providing CDAT or potentially treating the root port as a GI (though that =
runs into the same naming / representation issue as below and I think would=
 need some clarifying text in UEFI GI description)

http://uefi.org/sites/default/files/resources/Coherent%20Device%20Attribute=
%20Table_1.01.pdf

For the case you are dealing with here potentially we 'could' add something=
 to CDAT as alternative to changing SRAT, but it would be more complex so y=
our approach here makes more sense to me.

>=20
> ---
>=20
> # Title: Introduce a Generic Target for CXL
>=20
> # Status: Draft
>=20
> # Document: ACPI Specification 6.4
>=20
> # License
> SPDX-License Identifier: CC-BY-4.0
>=20
> # Submitter:
> * Sponsor: Dan Williams, Intel
> * Creators/Contributors:
>     * Mahesh Natu, Intel
>     * Chet Douglas, Intel
>     * Deepak Shivakumar, Intel
>=20
> # Summary of the Change
> Introduce a "Generic Target" concept to the SRAT to describe the root=20
> performance parameters in the path to dynamically discovered (outside=20
> of ACPI enumeration) CXL memory target endpoints.
>=20
> # Benefits of the Change
> Consider the case of a system with a set of CXL host bridges=20
> (ACPI0016),

Superficially feels like this new SRAT entry might reference the CXL 2.0 Ro=
ot ports or the host bridge.

> and no devices attached at initial system power-on. In this scenario=20
> platform firmware is unable to perform the end-to-end enumeration=20
> necessary to populate SRAT and HMAT for the endpoints that may be=20
> hot-inserted behind those bridges post power-on. The address-range is=20
> unknown so SRAT can not be pre-populated, the performance is unknown=20
> (no CDAT nor interleave configuration) so HMAT can not be pre-populated.
>=20
> However, what is known to platform firmware that generates the SRAT=20
> and HMAT is the performance characteristics of the path between CPU=20
> and Generic Initiators to the CXL host bridge target. With either=20
> CPU-to-Generic-Target, or Generic-Initiator-to-Generic-Target entries=20
> in the HMAT the OS CXL subsystem can enumerate the remaining details=20
> (PCIE link status, device CDAT, interleave configuration) to calculate=20
> the bandwidth and latency of a dynamically discovered CXL memory target.

I'm wondering if the term "generic target" is a good name.
Would something like "generic target bridge" be clearer?
The point being this isn't an actual target but a point along the way.
Mind you this is close to bike shedding.

As mentioned above, maybe "generic bridge" that can give us a node to hang =
data off for both, a) GI on CXL to host memory, and b) Initiator in host to=
 CXL memory and hence give cleaner representation.

>=20
> # Impact of the Change
> The existing Generic Initiator Affinity Structure (ACPI 6.4 Section
> 5.2.16.6) already contains all the fields necessary to enumerate a=20
> generic target proximity domain. All that is missing is the=20
> interpretation of that proximity domain optionally as a target=20
> identifier in the HMAT.
>=20
> Given that the OS still needs to dynamically enumerate and instantiate=20
> the memory ranges behind the host bridge. The assumption is that=20
> operating systems that do not support native CXL enumeration will=20
> ignore this data in the HMAT, while CXL native enumeration aware=20
> environments will use this fragment of the performance path to=20
> calculate the performance characteristics.

I don't think it is true that OS not supporting native CXL will ignore the =
data.

Linux will create a small amount of infrastructure to reflect them (more or=
 less the same as a memoryless node) and also they will appear in places li=
ke access0 as a possible initiator of transactions.  It's small stuff, but =
I'd rather the impact on legacy was zero.

So my gut feeling here is we shouldn't reuse the generic initiator, but sho=
uld invent something new.  Would look similar to GI, but with a different I=
D - to ensure legacy OS ignores it.

Unfortunately we can't just add a flag because backwards compatibility with=
 old OS would mean it was ignored.  Hence I think this needs to be a new ty=
pe.

If we define a new node type rather than extend GI, we need to be careful a=
round the same issue with _PXM that we had when introducing Generic Initiat=
ors (not sure the protections on that made it back to stable) so might need=
 to modify DSDT _PXM responses based on appropriate _OSC.
May well be fine but I'm not convinced yet.  Perhaps we need to say that us=
ing _PXM to place anything in a node defined only via this new means is not=
 valid.

Jonathan

>=20
> # References
> * Compute Express Link Specification v2.0,=20
> <https://www.computeexpresslink.org/>
>=20
> # Detailed Description of the Change
>=20
> * Replace "Generic Initiator" with "Generic Initiator / Target" in all=20
> locations except where an "initiator" or "target" is implied.
> Specifically 5.2.27.3 "Memory Proximity Domain Attributes Structure"
> need not replace occurrences of "generic initiator" in field:=20
> "Proximity Domain for Attached Initiator". Additionally field:=20
> "Proximity Domain for the Memory" must be renamed to "Proximity Domain=20
> for the Memory / Generic Target" with a new description "Integer that=20
> represents the memory / generic target proximity domain to which this mem=
ory belongs."
>=20
> * Revise "5.2.16.6 Generic Initiator Affinity Structure" to make it
>   consistent with being referenced as either a target or initiator.
>=20
>         * Description: (replace all text)
>=20
>         > The Generic Initiator / Target Affinity Structure provides the
>         > association between a Generic Initiator and a Memory Proximity
>         > Domain, or another Generic Target Proximity Domain. The
>         > distinction as to whether this structure represents an
>         > Initiator, a Target, or both depends on how it is referenced
>         > in the HMAT. See Section 5.2.27.3 for details. =20
>=20
>         > Support of Generic Initiator / Target Affinity Structures by
>         > OSPM is optional, and the platform may query whether the OS
>         > supports it via the _OSC method. See Section 6.2.11.2. =20
>=20
>         * Architectural transactions: (append after current text)
>=20
>         > If this proximity domain is referenced as a target then it
>         > supports all the transaction types inferred above. =20
>=20
>         * Other updates are simple Initiator =3D> Initiator / Target
>           replacements.


