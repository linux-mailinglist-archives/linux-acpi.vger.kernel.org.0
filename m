Return-Path: <linux-acpi+bounces-625-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C397C832D
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Oct 2023 12:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 383D8B20841
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Oct 2023 10:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B90125C4
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Oct 2023 10:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097B310965
	for <linux-acpi@vger.kernel.org>; Fri, 13 Oct 2023 09:07:27 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607EBBE;
	Fri, 13 Oct 2023 02:07:25 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S6LH72sX5z688J2;
	Fri, 13 Oct 2023 17:06:59 +0800 (CST)
Received: from localhost (10.126.172.163) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 13 Oct
 2023 10:07:22 +0100
Date: Fri, 13 Oct 2023 10:07:20 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Sridharan, Vilas" <Vilas.Sridharan@amd.com>
CC: "Duran, Leo" <leo.duran@amd.com>, "Ghannam, Yazen"
	<Yazen.Ghannam@amd.com>, David Rientjes <rientjes@google.com>, Jiaqi Yan
	<jiaqiyan@google.com>, "Luck, Tony" <tony.luck@intel.com>, "Grimm, Jon"
	<Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "linuxarm@huawei.com" <linuxarm@huawei.com>,
	"shiju.jose@huawei.com" <shiju.jose@huawei.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "david@redhat.com" <david@redhat.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "mike.malvestuto@intel.com"
	<mike.malvestuto@intel.com>, "gthelen@google.com" <gthelen@google.com>,
	"tanxiaofei@huawei.com" <tanxiaofei@huawei.com>, "prime.zeng@hisilicon.com"
	<prime.zeng@hisilicon.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, "wanghuiqiang@huawei.com"
	<wanghuiqiang@huawei.com>
Subject: Re: [RFC PATCH 2/9] memory: scrub: sysfs: Add Documentation entries
 for set of scrub attributes
Message-ID: <20231013100720.0000699e@Huawei.com>
In-Reply-To: <BL0PR12MB4673059A5AC97F648CD00FB1EAD3A@BL0PR12MB4673.namprd12.prod.outlook.com>
References: <20230915172818.761-1-shiju.jose@huawei.com>
	<20230915172818.761-3-shiju.jose@huawei.com>
	<CACw3F50jRzJnr9h7qYyD3t+6h7Uw9QMfkCkgu7a=7Lv0Tpi8Zg@mail.gmail.com>
	<20230922111740.000046d7@huawei.com>
	<CACw3F539gZc0FoJLo6VvYSyZmeWZ3Pbec7AzsH+MYUJJNzQbUQ@mail.gmail.com>
	<92f48c1c-3235-49b2-aabd-7da87ad3febc@google.com>
	<20231006140224.000018a2@Huawei.com>
	<BL0PR12MB4673F5E024B62D64B065DBE4EAC9A@BL0PR12MB4673.namprd12.prod.outlook.com>
	<20231011173553.00001b39@Huawei.com>
	<BL0PR12MB4673336E2BD4686AFF5EE737EAD3A@BL0PR12MB4673.namprd12.prod.outlook.com>
	<20231012160224.00003f87@Huawei.com>
	<BL0PR12MB4673059A5AC97F648CD00FB1EAD3A@BL0PR12MB4673.namprd12.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.172.163]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 12 Oct 2023 15:44:18 +0000
"Sridharan, Vilas" <Vilas.Sridharan@amd.com> wrote:

> [AMD Official Use Only - General]
> 
> > Are you thinking a code first proposal?  If you think doing this through the standards body is a good idea then perhaps message back here so we know when to look for further proposals in mantis.  
> 
> I am not super familiar with what you mean by 'code first proposal', but we are thinking about crafting an ECN (or a set of ECNs) for ACPI, that will be made public through ACPI's normal process.
> 
There are two ways to go about getting an ECN into the specification
and which one is chosen affects the 'made it public' part of the ECN.

One is public from the start and is done via a proposal submitted to the Specification
Updates section of the tianocore bugzilla. This is referred to as "code
first", but actually just means the request came from discussions initially
had outside of the UEFI forum. They are still discussed in ASWG, but review
also occurs in public on the bugzilla.
https://bugzilla.tianocore.org/buglist.cgi?component=Specification%20Update&product=EDK2%20Code%20First&resolution=---

The other is the more traditional method of proposing in private. There the issue
is that the review is limited to those who both engage closely with ASWG and those
who can remember their mantis password. Before we post any software based on changes
going via that route (as its covered by UEFI forum IP rules) we have to wait for a
formal specification release.  So basically the traditional method is typically slower
and doesn't let us do helpful things like ask the kernel community to review the
proposed changes. The code first route was added a few years ago to provide the
options for companies that preferred the flexibility and openness it provides.

As you can see from the link above, there is a lot of activity via the code
first route these days.

Jonathan


>     -Vilas
> 
> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Thursday, October 12, 2023 11:02 AM
> To: Sridharan, Vilas <Vilas.Sridharan@amd.com>
> Cc: Duran, Leo <leo.duran@amd.com>; Ghannam, Yazen <Yazen.Ghannam@amd.com>; David Rientjes <rientjes@google.com>; Jiaqi Yan <jiaqiyan@google.com>; Luck, Tony <tony.luck@intel.com>; Grimm, Jon <Jon.Grimm@amd.com>; dave.hansen@linux.intel.com; linuxarm@huawei.com; shiju.jose@huawei.com; linux-acpi@vger.kernel.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org; rafael@kernel.org; lenb@kernel.org; naoya.horiguchi@nec.com; james.morse@arm.com; david@redhat.com; jthoughton@google.com; somasundaram.a@hpe.com; erdemaktas@google.com; pgonda@google.com; duenwen@google.com; mike.malvestuto@intel.com; gthelen@google.com; tanxiaofei@huawei.com; prime.zeng@hisilicon.com; kangkang.shen@futurewei.com; wanghuiqiang@huawei.com
> Subject: Re: [RFC PATCH 2/9] memory: scrub: sysfs: Add Documentation entries for set of scrub attributes
> 
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Thu, 12 Oct 2023 13:41:19 +0000
> "Sridharan, Vilas" <Vilas.Sridharan@amd.com> wrote:
> 
> > [AMD Official Use Only - General]
> >
> > + Leo and Yazen  
> 
> Hi All.
> 
> + Kangkang and Wanghuiqiang (Henson),
> 
> >
> > We looked at RASF and RAS2 again. We don't think RASF is worth fixing. Our preference is to coalesce around RAS2 because we think it can be extended in interesting ways.  
> 
> Absolutely agree. I'm guessing RAS2 was previous go at fixing RASF though I haven't done the archaeology.
> 
> >
> > The patrol scrub function probably needs some changes to be more general across different types of hardware (there are some baked-in assumptions that don't always hold true).  
> 
> Agreed. One aspect I'd love to see improved is expanded discoverability of what the hardware can do.
> 
> >
> > We will look at some spec changes to fix the patrol scrub function, and we are going to start thinking about other functions that can be added to RAS2.  
> 
> Feel free to reach out if you want some early input on this. Are you thinking a code first proposal?  If you think doing this through the standards body is a good idea then perhaps message back here so we know when to look for further proposals in mantis.
> 
> Thanks,
> 
> Jonathan
> >
> >     -Vilas
> >
> > -----Original Message-----
> > From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Sent: Wednesday, October 11, 2023 12:36 PM
> > To: Sridharan, Vilas <Vilas.Sridharan@amd.com>
> > Cc: David Rientjes <rientjes@google.com>; Jiaqi Yan
> > <jiaqiyan@google.com>; Luck, Tony <tony.luck@intel.com>; Grimm, Jon
> > <Jon.Grimm@amd.com>; dave.hansen@linux.intel.com; linuxarm@huawei.com;
> > shiju.jose@huawei.com; linux-acpi@vger.kernel.org; linux-mm@kvack.org;
> > linux-kernel@vger.kernel.org; rafael@kernel.org; lenb@kernel.org;
> > naoya.horiguchi@nec.com; james.morse@arm.com; david@redhat.com;
> > jthoughton@google.com; somasundaram.a@hpe.com; erdemaktas@google.com;
> > pgonda@google.com; duenwen@google.com; mike.malvestuto@intel.com;
> > gthelen@google.com; tanxiaofei@huawei.com; prime.zeng@hisilicon.com
> > Subject: Re: [RFC PATCH 2/9] memory: scrub: sysfs: Add Documentation
> > entries for set of scrub attributes
> >
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> >
> >
> > On Fri, 6 Oct 2023 13:06:53 +0000
> > "Sridharan, Vilas" <Vilas.Sridharan@amd.com> wrote:
> >  
> > > [AMD Official Use Only - General]
> > >
> > > I do not believe AMD has implemented RASF/RAS2 at all.
> > >
> > > We are looking at it, but our initial impression is that it is
> > > insufficiently flexible for general use. (Not just for this feature,
> > > but for others in the future.)
> > >
> > >     -Vilas  
> >
> > Hi Vilas,
> >
> > So obvious question is - worth fixing?
> >
> > I'm not particularly keen to see 10+ different ways of meeting this requirement.
> >
> > Probably not too bad if that's 10+ drivers implementing the same userspace ABI, but definitely don't want 10 drivers and 10 ABIs.
> >
> > Jonathan
> >  
> > >
> > > -----Original Message-----
> > > From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > > Sent: Friday, October 6, 2023 9:02 AM
> > > To: David Rientjes <rientjes@google.com>
> > > Cc: Jiaqi Yan <jiaqiyan@google.com>; Luck, Tony
> > > <tony.luck@intel.com>; Grimm, Jon <Jon.Grimm@amd.com>;
> > > dave.hansen@linux.intel.com; Sridharan, Vilas
> > > <Vilas.Sridharan@amd.com>; linuxarm@huawei.com;
> > > shiju.jose@huawei.com; linux-acpi@vger.kernel.org;
> > > linux-mm@kvack.org; linux-kernel@vger.kernel.org; rafael@kernel.org;
> > > lenb@kernel.org; naoya.horiguchi@nec.com; james.morse@arm.com;
> > > david@redhat.com; jthoughton@google.com; somasundaram.a@hpe.com;
> > > erdemaktas@google.com; pgonda@google.com; duenwen@google.com;
> > > mike.malvestuto@intel.com; gthelen@google.com;
> > > tanxiaofei@huawei.com; prime.zeng@hisilicon.com
> > > Subject: Re: [RFC PATCH 2/9] memory: scrub: sysfs: Add Documentation
> > > entries for set of scrub attributes
> > >
> > > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > >
> > >
> > > On Wed, 4 Oct 2023 20:18:12 -0700 (PDT) David Rientjes
> > > <rientjes@google.com> wrote:
> > >  
> > > > On Wed, 27 Sep 2023, Jiaqi Yan wrote:
> > > >  
> > > > > > > 1. I am not aware of any chip/platform hardware that
> > > > > > > implemented the hw ps part defined in ACPI RASF/RAS2 spec.
> > > > > > > So I am curious what the RAS experts from different hardware
> > > > > > > vendors think about this. For example, Tony and Dave from
> > > > > > > Intel, Jon and Vilas from AMD. Is there any hardware
> > > > > > > platform (if allowed to disclose) that implemented ACPI
> > > > > > > RASF/RAS2? If so, will vendors continue to support the
> > > > > > > control of patrol scrubber using the ACPI spec? If not (as Tony said in [1], will the vendor consider starting some future platform?
> > > > > > >
> > > > > > > If we are unlikely to get the vendor support, creating this
> > > > > > > ACPI specific sysfs API (and the driver implementations) in
> > > > > > > Linux seems to have limited meaning.  
> > > > > >
> > > > > > There is a bit of a chicken and egg problem here. Until there
> > > > > > is reasonable support in kernel (or it looks like there will
> > > > > > be), BIOS teams push back on a requirement to add the tables.
> > > > > > I'd encourage no one to bother with RASF - RAS2 is much less
> > > > > > ambiguous.  
> > > > >
> > > > > Here mainly to re-ping folks from Intel (Tony and Dave)  and AMD
> > > > > (Jon and Vilas) for your opinion on RAS2.
> > > > >  
> > > >
> > > > We'll need to know from vendors, ideally at minimum from both
> > > > Intel and AMD, whether RAS2 is the long-term vision here.  Nothing
> > > > is set in stone, of course, but deciding whether RAS2 is the
> > > > standard that we should be rallying around will help to guide
> > > > future development including in the kernel.
> > > >
> > > > If RAS2 is insufficient for future use cases or we would need to
> > > > support multiple implementations in the kernel for configuring the
> > > > patrol scrubber depending on vendor, that's great feedback to have.
> > > >
> > > > I'd much rather focus on implementing something in the kernel that
> > > > we have some clarity about the vendors supporting, especially when
> > > > it comes with user visible interfaces, as opposed to something
> > > > that may not be used long term.  I think that's a fair ask and
> > > > that vendor feedback is required here?  
> > >
> > > Agreed and happy to have feedback from Intel and AMD + all the other CPU vendors who make use of ACPI + all the OEMs who add stuff well beyond what Intel and AMD tell them to :)  I'll just note a lot of the ACPI support in the kernel covers stuff not used on mainstream x86 platforms because they are doing something custom and we didn't want 2 + X custom implementations...
> > >
> > > Some other interfaces for scrub control (beyond existing embedded ones) will surface in the next few months where RAS2 is not appropriate.
> > >
> > > Jonathan
> > >
> > >  
> >  
> 


