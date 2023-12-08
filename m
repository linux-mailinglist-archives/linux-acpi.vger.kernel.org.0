Return-Path: <linux-acpi+bounces-2230-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 401F380A582
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 15:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386811C20CD5
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 14:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78A41E534
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 14:32:42 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3157D172B;
	Fri,  8 Dec 2023 05:48:33 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SmssF151cz6JB1X;
	Fri,  8 Dec 2023 21:47:45 +0800 (CST)
Received: from lhrpeml500002.china.huawei.com (unknown [7.191.160.78])
	by mail.maildlp.com (Postfix) with ESMTPS id 9394D14011D;
	Fri,  8 Dec 2023 21:48:30 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml500002.china.huawei.com (7.191.160.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 13:48:30 +0000
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.035;
 Fri, 8 Dec 2023 13:48:30 +0000
From: Shiju Jose <shiju.jose@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"dave@stgolabs.net" <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>
CC: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
	<rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "Jon.Grimm@amd.com"
	<Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "mike.malvestuto@intel.com"
	<mike.malvestuto@intel.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>, wanghuiqiang
	<wanghuiqiang@huawei.com>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v4 00/11] cxl: Add support for CXL feature commands, CXL
 device patrol scrub control and DDR5 ECS control features
Thread-Topic: [PATCH v4 00/11] cxl: Add support for CXL feature commands, CXL
 device patrol scrub control and DDR5 ECS control features
Thread-Index: AQHaI8KwgMGD3E1NJkm1EO0u0hTVFbCcsBMAgAJ2I3A=
Date: Fri, 8 Dec 2023 13:48:30 +0000
Message-ID: <9bc4b5fac46d4f37b675de4e0f65931b@huawei.com>
References: <20231130192314.1220-1-shiju.jose@huawei.com>
 <6570cdbaa96e0_45e01294e0@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <6570cdbaa96e0_45e01294e0@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Dan,

Thanks  for the feedbacks.

>-----Original Message-----
>From: Dan Williams <dan.j.williams@intel.com>
>Sent: 06 December 2023 19:39
>To: Shiju Jose <shiju.jose@huawei.com>; linux-cxl@vger.kernel.org; linux-
>mm@kvack.org; dave@stgolabs.net; Jonathan Cameron
><jonathan.cameron@huawei.com>; dave.jiang@intel.com;
>alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>dan.j.williams@intel.com
>Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org;
>david@redhat.com; Vilas.Sridharan@amd.com; leo.duran@amd.com;
>Yazen.Ghannam@amd.com; rientjes@google.com; jiaqiyan@google.com;
>tony.luck@intel.com; Jon.Grimm@amd.com; dave.hansen@linux.intel.com;
>rafael@kernel.org; lenb@kernel.org; naoya.horiguchi@nec.com;
>james.morse@arm.com; jthoughton@google.com; somasundaram.a@hpe.com;
>erdemaktas@google.com; pgonda@google.com; duenwen@google.com;
>mike.malvestuto@intel.com; gthelen@google.com;
>wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
>tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>=
;
>kangkang.shen@futurewei.com; wanghuiqiang <wanghuiqiang@huawei.com>;
>Linuxarm <linuxarm@huawei.com>; Shiju Jose <shiju.jose@huawei.com>
>Subject: RE: [PATCH v4 00/11] cxl: Add support for CXL feature commands, C=
XL
>device patrol scrub control and DDR5 ECS control features
>
>Hi Shiju,
>
>I have some general feedback at this point before digging too deep into th=
e
>details:
>
>shiju.jose@ wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> 1. Add support for CXL feature mailbox commands.
>> 2. Add CXL device scrub driver supporting patrol scrub control and
>> DDR5 ECS control features.
>> 3. Add scrub driver supports configuring memory scrubs in the system.
>> 4. Add scrub attributes for DDR5 ECS control to the memory scrub driver.
>
>For a new a subsystem that is meant to generically abstract a "memory scru=
b"
>facility the "DDR5 ECS" naming has too much precision. How much of this
>interface is DDR5 ECS specific and how much of it is applicable to a theor=
etical
>DDR6 scrub implementation?
>
>My primary reaction is to boil down this interface so that only generic sc=
rub
>details are visible in the ABI, and DDR5 specifics are invisible in the sy=
sfs ABI.
Sure. I will check this.

>
>For example the Linux NVDIMM subsystem has an address-range-scrub facility
>that is independent of the specific memory technology scrub mechanism. Tha=
t
>one is based on ACPI NFIT, but I realize you also looked at enabling the A=
CPI
>RASF scrub interface. It would be useful if this patchset could plausibly =
enable
>one non-CXL scrubber along with the CXL one.
Sure. I will do this. I will add ACPI RASF scrub patches to this patch set.

>
>> 5. Register CXL device patrol scrub and ECS with scrub control driver.
>> 6. Add documentation for common attributes in the scrub configure driver=
.
>
>Going forward, please include the Documentation in the patch that adds the=
 new
>ABI, it improves the readability / story-telling of the patches.
>It also makes it easier to analyze which code is needed for which ABI, and
>whether a given ABI is justified.
I will do.

>
>The regionY nomenclature in the sysfs ABI looks like a potential opportuni=
ty to
>align with the "memregion" id scheme. See all the callers of memregion_all=
oc()
>where those are tagging device-backed physical address ranges with a commo=
n
>id namespace. It would be great if the memory-scrub ABI reported failures =
in
>terms of region-ids that correlate with CXL, DAX, or NVDIMM regions.
For the CXL DDR5 ECS feature, presently the regionY  corresponds to the IDs=
 of the
memory media FRUs (1 to N),  defined in the DDR5 ECS Control Feature tables=
 Table 8-210 and  Table 8-211.=20
=20
>
>> 7. Add documentation for CXL memory device scrub control attributes.
>
>Do the CXL specifics need to be in the ABI? One thing I missed was how the
Ok. I will remove. Should these DDR5 ECS specifics consider as generic and=
=20
be part of the memory scrub ABI?     =20
>series of log entries are conveyed. For CXL in contrast to what NVDIMM did=
 for
>address range scrub is that CXL makes use of trace-events to emit log reco=
rds.
>That allows the sysfs ABI to remain relatively simple, but the various tra=
ce-
>events can get into more protocol specific details. For example, see
>cxl_trigger_poison_list() and
>trace_cxl_poison() as a way to genericly trigger the listing of a flow of =
device-
>specific details. In other words put the DDR5 ECS specifics in the trace-e=
vent, not
>the sysfs ABI if possible.
Did you mean remove the readable attributes for DDR5 ECS from the sysfs?
For example the "ECS Threshold Count per Gb of Memory Cells" and "Codeword/=
Row Count Mode"
in the Table 8-78 DDR5 ECS log  of  section 8.2.9.5.2.4 DDR5 Error Check Sc=
rub (ECS) Log.
 =20
>
>Lastly, dynamically defined sysfs groups are less palatable than staticall=
y
>defined. See cxl_region_target_visible() for a scheme for statically defin=
ing a
>runtime variable number of attributes.
>Specifically I would like to see a way to define this new subsystem withou=
t
>scrub_create_attrs() and all the runtime attribute definition.
>
Sure. I will check this.

>Overall, I like the general approach to define a common subsystem for this=
, and
>get off the treadmill of reinventing custom scrub interfaces per bus, but =
that
>also requires that it be generic enough to subsume a number of those per-b=
us-
>scrub-types.
This is the challenging part to make the scrub interface generic because th=
e scrub control
varies between the scrub types, for example as seen in the CXL ECS.

Thanks,
Shiju

