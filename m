Return-Path: <linux-acpi+bounces-596-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571E47C5B66
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Oct 2023 20:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09815281076
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Oct 2023 18:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B1C22318
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Oct 2023 18:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993523E49A
	for <linux-acpi@vger.kernel.org>; Wed, 11 Oct 2023 16:36:00 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2700B6;
	Wed, 11 Oct 2023 09:35:57 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S5JGW5d5hz6JB4n;
	Thu, 12 Oct 2023 00:32:51 +0800 (CST)
Received: from localhost (10.126.175.8) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 17:35:54 +0100
Date: Wed, 11 Oct 2023 17:35:53 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Sridharan, Vilas" <Vilas.Sridharan@amd.com>
CC: David Rientjes <rientjes@google.com>, Jiaqi Yan <jiaqiyan@google.com>,
	"Luck, Tony" <tony.luck@intel.com>, "Grimm, Jon" <Jon.Grimm@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linuxarm@huawei.com" <linuxarm@huawei.com>, "shiju.jose@huawei.com"
	<shiju.jose@huawei.com>, "linux-acpi@vger.kernel.org"
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
	<prime.zeng@hisilicon.com>
Subject: Re: [RFC PATCH 2/9] memory: scrub: sysfs: Add Documentation entries
 for set of scrub attributes
Message-ID: <20231011173553.00001b39@Huawei.com>
In-Reply-To: <BL0PR12MB4673F5E024B62D64B065DBE4EAC9A@BL0PR12MB4673.namprd12.prod.outlook.com>
References: <20230915172818.761-1-shiju.jose@huawei.com>
	<20230915172818.761-3-shiju.jose@huawei.com>
	<CACw3F50jRzJnr9h7qYyD3t+6h7Uw9QMfkCkgu7a=7Lv0Tpi8Zg@mail.gmail.com>
	<20230922111740.000046d7@huawei.com>
	<CACw3F539gZc0FoJLo6VvYSyZmeWZ3Pbec7AzsH+MYUJJNzQbUQ@mail.gmail.com>
	<92f48c1c-3235-49b2-aabd-7da87ad3febc@google.com>
	<20231006140224.000018a2@Huawei.com>
	<BL0PR12MB4673F5E024B62D64B065DBE4EAC9A@BL0PR12MB4673.namprd12.prod.outlook.com>
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
X-Originating-IP: [10.126.175.8]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 6 Oct 2023 13:06:53 +0000
"Sridharan, Vilas" <Vilas.Sridharan@amd.com> wrote:

> [AMD Official Use Only - General]
> 
> I do not believe AMD has implemented RASF/RAS2 at all.
> 
> We are looking at it, but our initial impression is that it is insufficiently flexible for general use. (Not just for this feature, but for others in the future.)
> 
>     -Vilas

Hi Vilas,

So obvious question is - worth fixing?

I'm not particularly keen to see 10+ different ways of meeting this requirement.

Probably not too bad if that's 10+ drivers implementing the same userspace ABI, but
definitely don't want 10 drivers and 10 ABIs.

Jonathan

> 
> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Friday, October 6, 2023 9:02 AM
> To: David Rientjes <rientjes@google.com>
> Cc: Jiaqi Yan <jiaqiyan@google.com>; Luck, Tony <tony.luck@intel.com>; Grimm, Jon <Jon.Grimm@amd.com>; dave.hansen@linux.intel.com; Sridharan, Vilas <Vilas.Sridharan@amd.com>; linuxarm@huawei.com; shiju.jose@huawei.com; linux-acpi@vger.kernel.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org; rafael@kernel.org; lenb@kernel.org; naoya.horiguchi@nec.com; james.morse@arm.com; david@redhat.com; jthoughton@google.com; somasundaram.a@hpe.com; erdemaktas@google.com; pgonda@google.com; duenwen@google.com; mike.malvestuto@intel.com; gthelen@google.com; tanxiaofei@huawei.com; prime.zeng@hisilicon.com
> Subject: Re: [RFC PATCH 2/9] memory: scrub: sysfs: Add Documentation entries for set of scrub attributes
> 
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Wed, 4 Oct 2023 20:18:12 -0700 (PDT)
> David Rientjes <rientjes@google.com> wrote:
> 
> > On Wed, 27 Sep 2023, Jiaqi Yan wrote:
> >  
> > > > > 1. I am not aware of any chip/platform hardware that implemented
> > > > > the hw ps part defined in ACPI RASF/RAS2 spec. So I am curious
> > > > > what the RAS experts from different hardware vendors think about
> > > > > this. For example, Tony and Dave from Intel, Jon and Vilas from
> > > > > AMD. Is there any hardware platform (if allowed to disclose)
> > > > > that implemented ACPI RASF/RAS2? If so, will vendors continue to
> > > > > support the control of patrol scrubber using the ACPI spec? If
> > > > > not (as Tony said in [1], will the vendor consider starting some future platform?
> > > > >
> > > > > If we are unlikely to get the vendor support, creating this ACPI
> > > > > specific sysfs API (and the driver implementations) in Linux
> > > > > seems to have limited meaning.  
> > > >
> > > > There is a bit of a chicken and egg problem here. Until there is
> > > > reasonable support in kernel (or it looks like there will be),
> > > > BIOS teams push back on a requirement to add the tables.
> > > > I'd encourage no one to bother with RASF - RAS2 is much less
> > > > ambiguous.  
> > >
> > > Here mainly to re-ping folks from Intel (Tony and Dave)  and AMD
> > > (Jon and Vilas) for your opinion on RAS2.
> > >  
> >
> > We'll need to know from vendors, ideally at minimum from both Intel
> > and AMD, whether RAS2 is the long-term vision here.  Nothing is set in
> > stone, of course, but deciding whether RAS2 is the standard that we
> > should be rallying around will help to guide future development
> > including in the kernel.
> >
> > If RAS2 is insufficient for future use cases or we would need to
> > support multiple implementations in the kernel for configuring the
> > patrol scrubber depending on vendor, that's great feedback to have.
> >
> > I'd much rather focus on implementing something in the kernel that we
> > have some clarity about the vendors supporting, especially when it
> > comes with user visible interfaces, as opposed to something that may
> > not be used long term.  I think that's a fair ask and that vendor
> > feedback is required here?  
> 
> Agreed and happy to have feedback from Intel and AMD + all the other CPU vendors who make use of ACPI + all the OEMs who add stuff well beyond what Intel and AMD tell them to :)  I'll just note a lot of the ACPI support in the kernel covers stuff not used on mainstream x86 platforms because they are doing something custom and we didn't want 2 + X custom implementations...
> 
> Some other interfaces for scrub control (beyond existing embedded ones) will surface in the next few months where RAS2 is not appropriate.
> 
> Jonathan
> 
> 


