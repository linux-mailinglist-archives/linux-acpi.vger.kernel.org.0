Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9FE36643B
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Apr 2021 06:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhDUEGl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 21 Apr 2021 00:06:41 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3404 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhDUEGk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Apr 2021 00:06:40 -0400
Received: from dggeme712-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FQ6N815lbz5r4G;
        Wed, 21 Apr 2021 12:03:04 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme712-chm.china.huawei.com (10.1.199.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 21 Apr 2021 12:06:03 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Wed, 21 Apr 2021 12:06:03 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>
CC:     "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "msys.mizuma@gmail.com" <msys.mizuma@gmail.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "aubrey.li@linux.intel.com" <aubrey.li@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "xuwei (O)" <xuwei5@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        yangyicong <yangyicong@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [RFC PATCH v5 1/4] topology: Represent clusters of CPUs within a
 die
Thread-Topic: [RFC PATCH v5 1/4] topology: Represent clusters of CPUs within a
 die
Thread-Index: AQHXHHeQcl1lHq1u7kWPO6cWrdJxq6qKVPyAgACJR5D//6lPAIAAByuAgDJgJ6CAAZz6gA==
Date:   Wed, 21 Apr 2021 04:06:03 +0000
Message-ID: <be2755fd4f1447cb97c4de04eb378a0b@hisilicon.com>
References: <20210319041618.14316-1-song.bao.hua@hisilicon.com>
 <20210319041618.14316-2-song.bao.hua@hisilicon.com>
 <YFRGIedW1fUlnmi+@kroah.com> <eb48302277f3436eb9899032e6b0bf1c@hisilicon.com>
 <20210319093616.00001879@Huawei.com> <YFR2kwakbcGiI37w@kroah.com> 
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Song Bao Hua (Barry Song)
> Sent: Tuesday, April 20, 2021 3:24 PM
> To: 'Greg KH' <gregkh@linuxfoundation.org>; Jonathan Cameron
> <jonathan.cameron@huawei.com>
> Cc: tim.c.chen@linux.intel.com; catalin.marinas@arm.com; will@kernel.org;
> rjw@rjwysocki.net; vincent.guittot@linaro.org; bp@alien8.de;
> tglx@linutronix.de; mingo@redhat.com; lenb@kernel.org; peterz@infradead.org;
> dietmar.eggemann@arm.com; rostedt@goodmis.org; bsegall@google.com;
> mgorman@suse.de; msys.mizuma@gmail.com; valentin.schneider@arm.com;
> juri.lelli@redhat.com; mark.rutland@arm.com; sudeep.holla@arm.com;
> aubrey.li@linux.intel.com; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org; x86@kernel.org;
> xuwei (O) <xuwei5@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>;
> guodong.xu@linaro.org; yangyicong <yangyicong@huawei.com>; Liguozhu (Kenneth)
> <liguozhu@hisilicon.com>; linuxarm@openeuler.org; hpa@zytor.com; tiantao (H)
> <tiantao6@hisilicon.com>
> Subject: RE: [RFC PATCH v5 1/4] topology: Represent clusters of CPUs within
> a die
> 
> 
> 
> > -----Original Message-----
> > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > Sent: Friday, March 19, 2021 11:02 PM
> > To: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>;
> > tim.c.chen@linux.intel.com; catalin.marinas@arm.com; will@kernel.org;
> > rjw@rjwysocki.net; vincent.guittot@linaro.org; bp@alien8.de;
> > tglx@linutronix.de; mingo@redhat.com; lenb@kernel.org;
> peterz@infradead.org;
> > dietmar.eggemann@arm.com; rostedt@goodmis.org; bsegall@google.com;
> > mgorman@suse.de; msys.mizuma@gmail.com; valentin.schneider@arm.com;
> > juri.lelli@redhat.com; mark.rutland@arm.com; sudeep.holla@arm.com;
> > aubrey.li@linux.intel.com; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org; x86@kernel.org;
> > xuwei (O) <xuwei5@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>;
> > guodong.xu@linaro.org; yangyicong <yangyicong@huawei.com>; Liguozhu
> (Kenneth)
> > <liguozhu@hisilicon.com>; linuxarm@openeuler.org; hpa@zytor.com
> > Subject: Re: [RFC PATCH v5 1/4] topology: Represent clusters of CPUs within
> > a die
> >
> > On Fri, Mar 19, 2021 at 09:36:16AM +0000, Jonathan Cameron wrote:
> > > On Fri, 19 Mar 2021 06:57:08 +0000
> > > "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com> wrote:
> > >
> > > > > -----Original Message-----
> > > > > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > > > > Sent: Friday, March 19, 2021 7:35 PM
> > > > > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> > > > > Cc: tim.c.chen@linux.intel.com; catalin.marinas@arm.com;
> > will@kernel.org;
> > > > > rjw@rjwysocki.net; vincent.guittot@linaro.org; bp@alien8.de;
> > > > > tglx@linutronix.de; mingo@redhat.com; lenb@kernel.org;
> > peterz@infradead.org;
> > > > > dietmar.eggemann@arm.com; rostedt@goodmis.org; bsegall@google.com;
> > > > > mgorman@suse.de; msys.mizuma@gmail.com; valentin.schneider@arm.com;
> > Jonathan
> > > > > Cameron <jonathan.cameron@huawei.com>; juri.lelli@redhat.com;
> > > > > mark.rutland@arm.com; sudeep.holla@arm.com; aubrey.li@linux.intel.com;
> > > > > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > > > > linux-acpi@vger.kernel.org; x86@kernel.org; xuwei (O)
> > <xuwei5@huawei.com>;
> > > > > Zengtao (B) <prime.zeng@hisilicon.com>; guodong.xu@linaro.org;
> > yangyicong
> > > > > <yangyicong@huawei.com>; Liguozhu (Kenneth) <liguozhu@hisilicon.com>;
> > > > > linuxarm@openeuler.org; hpa@zytor.com
> > > > > Subject: Re: [RFC PATCH v5 1/4] topology: Represent clusters of CPUs
> within
> > > > > a die
> > > > >
> > > > > On Fri, Mar 19, 2021 at 05:16:15PM +1300, Barry Song wrote:
> > > > > > diff --git a/Documentation/admin-guide/cputopology.rst
> > > > > b/Documentation/admin-guide/cputopology.rst
> > > > > > index b90dafc..f9d3745 100644
> > > > > > --- a/Documentation/admin-guide/cputopology.rst
> > > > > > +++ b/Documentation/admin-guide/cputopology.rst
> > > > > > @@ -24,6 +24,12 @@ core_id:
> > > > > >  	identifier (rather than the kernel's).  The actual value is
> > > > > >  	architecture and platform dependent.
> > > > > >
> > > > > > +cluster_id:
> > > > > > +
> > > > > > +	the Cluster ID of cpuX.  Typically it is the hardware platform's
> > > > > > +	identifier (rather than the kernel's).  The actual value is
> > > > > > +	architecture and platform dependent.
> > > > > > +
> > > > > >  book_id:
> > > > > >
> > > > > >  	the book ID of cpuX. Typically it is the hardware platform's
> > > > > > @@ -56,6 +62,14 @@ package_cpus_list:
> > > > > >  	human-readable list of CPUs sharing the same physical_package_id.
> > > > > >  	(deprecated name: "core_siblings_list")
> > > > > >
> > > > > > +cluster_cpus:
> > > > > > +
> > > > > > +	internal kernel map of CPUs within the same cluster.
> > > > > > +
> > > > > > +cluster_cpus_list:
> > > > > > +
> > > > > > +	human-readable list of CPUs within the same cluster.
> > > > > > +
> > > > > >  die_cpus:
> > > > > >
> > > > > >  	internal kernel map of CPUs within the same die.
> > > > >
> > > > > Why are these sysfs files in this file, and not in a Documentation/ABI/
> > > > > file which can be correctly parsed and shown to userspace?
> > > >
> > > > Well. Those ABIs have been there for much a long time. It is like:
> > > >
> > > > [root@ceph1 topology]# ls
> > > > core_id  core_siblings  core_siblings_list  physical_package_id
> > thread_siblings  thread_siblings_list
> > > > [root@ceph1 topology]# pwd
> > > > /sys/devices/system/cpu/cpu100/topology
> > > > [root@ceph1 topology]# cat core_siblings_list
> > > > 64-127
> > > > [root@ceph1 topology]#
> > > >
> > > > >
> > > > > Any chance you can fix that up here as well?
> > > >
> > > > Yes. we will send a separate patch to address this, which won't
> > > > be in this patchset. This patchset will base on that one.
> > > >
> > > > >
> > > > > Also note that "list" is not something that goes in sysfs, sysfs is
> "one
> > > > > value per file", and a list is not "one value".  How do you prevent
> > > > > overflowing the buffer of the sysfs file if you have a "list"?
> > > > >
> > > >
> > > > At a glance, the list is using "-" rather than a real list
> > > > [root@ceph1 topology]# cat core_siblings_list
> > > > 64-127
> > > >
> > > > Anyway, I will take a look if it has any chance to overflow.
> > >
> > > It could in theory be alternate CPUs as comma separated list.
> > > So it's would get interesting around 500-1000 cpus (guessing).
> > >
> > > Hopefully no one has that crazy a cpu numbering scheme but it's possible
> > > (note that cluster is fine for this, but I guess it might eventually
> > > happen for core-siblings list (cpus within a package).
> > >
> > > Shouldn't crash or anything like that but might terminate early.
> >
> > We have a broken sysfs api already for listing LED numbers that has had
> > to be worked around in the past, please do not create a new one with
> > that same problem, we should learn from them :)
> 
> Another place I am seeing a cpu list is in numa topology:
> /sys/devices/system/node/nodex/cpulist.
> 
> But the code has a BUILD_BUG_ON to guard the pagebuf:
> 
> static ssize_t node_read_cpumap(struct device *dev, bool list, char *buf)
> {
> 	ssize_t n;
> 	cpumask_var_t mask;
> 	struct node *node_dev = to_node(dev);
> 
> 	/* 2008/04/07: buf currently PAGE_SIZE, need 9 chars per 32 bits. */
> 	BUILD_BUG_ON((NR_CPUS/32 * 9) > (PAGE_SIZE-1));
> 
> 	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
> 		return 0;
> 
> 	cpumask_and(mask, cpumask_of_node(node_dev->dev.id), cpu_online_mask);
> 	n = cpumap_print_to_pagebuf(list, buf, mask);
> 	free_cpumask_var(mask);
> 
> 	return n;
> }
> 
> For lists in cpu topology, I haven't seen this while I believe we need it.
> Or am I missing something?

I would prefer we send two patches as a series
"clarify and cleanup CPU and NUMA topology ABIs" with a cover
letter and the below one as 1/2. 2/2 would be the patch moving
the place of cpu topology ABI doc.

From b32c0c00a187d4fe4c49d54d30650b0cacb2c351 Mon Sep 17 00:00:00 2001
From: Tian Tao <tiantao6@hisilicon.com>
Date: Wed, 21 Apr 2021 14:36:11 +1200
Subject: [PATCH 1/2] CPU, NUMA topology ABIs: clarify the overflow issue of sysfs
 pagebuf

Both numa node and cpu use cpu bitmap like 3,ffffffff to expose hardware
topology. When cpu number is large, the page buffer of sysfs will over-
flow. This doesn't really happen nowadays as the maximum NR_CPUS is 8196
for X86_64 and 4096 for ARM64 since 8196 * 9 / 32 = 2305 is still smaller
than 4KB page size.
So the existing BUILD_BUG_ON() in drivers/base/node.c is pretty much
preventing future problems similar with Y2K when hardware gets more
and more CPUs.
On the other hand, it should be more sensible to move the guard to common
code which can protect both cpu and numa:
/sys/devices/system/cpu/cpu0/topology/die_cpus etc.
/sys/devices/system/node/node0/cpumap etc.

Topology bitmap mask strings shouldn't be larger than PAGE_SIZE as
lstopo and numactl depend on them. But other ABIs exposing cpu lists
are not really used by common applications, so this patch also marks
those lists could be trimmed as there is no any guarantee those lists
are always less than PAGE_SIZE especially a list could be like this:
0, 3, 5, 7, 9, 11... etc.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 Documentation/ABI/stable/sysfs-devices-node |  5 ++++-
 Documentation/admin-guide/cputopology.rst   | 15 +++++++++++++++
 drivers/base/node.c                         |  3 ---
 include/linux/cpumask.h                     |  6 ++++++
 4 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
index 484fc04bcc25..9832a17b2b15 100644
--- a/Documentation/ABI/stable/sysfs-devices-node
+++ b/Documentation/ABI/stable/sysfs-devices-node
@@ -47,7 +47,10 @@ What:		/sys/devices/system/node/nodeX/cpulist
 Date:		October 2002
 Contact:	Linux Memory Management list <linux-mm@kvack.org>
 Description:
-		The CPUs associated to the node.
+		The CPUs associated to the node. The format is like 0-3,
+		8-11, 12-13. The maximum size is PAGE_SIZE, so the tail
+		of the string will be trimmed while its size is larger
+		than PAGE_SIZE.
 
 What:		/sys/devices/system/node/nodeX/meminfo
 Date:		October 2002
diff --git a/Documentation/admin-guide/cputopology.rst b/Documentation/admin-guide/cputopology.rst
index b90dafcc8237..8fac776a5ffa 100644
--- a/Documentation/admin-guide/cputopology.rst
+++ b/Documentation/admin-guide/cputopology.rst
@@ -44,6 +44,9 @@ core_cpus:
 core_cpus_list:
 
 	human-readable list of CPUs within the same core.
+	The format is like 0-3, 8-11, 12-13. The maximum size is PAGE_SIZE,
+	so the tail of the string will be trimmed while its size is larger
+	than PAGE_SIZE.
 	(deprecated name: "thread_siblings_list");
 
 package_cpus:
@@ -54,6 +57,9 @@ package_cpus:
 package_cpus_list:
 
 	human-readable list of CPUs sharing the same physical_package_id.
+	The format is like 0-3, 8-11, 12-13. The maximum size is PAGE_SIZE,
+	so the tail of the string will be trimmed while its size is larger
+	than PAGE_SIZE.
 	(deprecated name: "core_siblings_list")
 
 die_cpus:
@@ -63,6 +69,9 @@ die_cpus:
 die_cpus_list:
 
 	human-readable list of CPUs within the same die.
+	The format is like 0-3, 8-11, 12-13. The maximum size is PAGE_SIZE,
+	so the tail of the string will be trimmed while its size is larger
+	than PAGE_SIZE.
 
 book_siblings:
 
@@ -73,6 +82,9 @@ book_siblings_list:
 
 	human-readable list of cpuX's hardware threads within the same
 	book_id.
+	The format is like 0-3, 8-11, 12-13. The maximum size is PAGE_SIZE,
+	so the tail of the string will be trimmed while its size is larger
+	than PAGE_SIZE.
 
 drawer_siblings:
 
@@ -83,6 +95,9 @@ drawer_siblings_list:
 
 	human-readable list of cpuX's hardware threads within the same
 	drawer_id.
+	The format is like 0-3, 8-11, 12-13. The maximum size is PAGE_SIZE,
+	so the tail of the string will be trimmed while its size is larger
+	than PAGE_SIZE.
 
 Architecture-neutral, drivers/base/topology.c, exports these attributes.
 However, the book and drawer related sysfs files will only be created if
diff --git a/drivers/base/node.c b/drivers/base/node.c
index f449dbb2c746..50324d06bcd5 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -33,9 +33,6 @@ static ssize_t node_read_cpumap(struct device *dev, bool list, char *buf)
 	cpumask_var_t mask;
 	struct node *node_dev = to_node(dev);
 
-	/* 2008/04/07: buf currently PAGE_SIZE, need 9 chars per 32 bits. */
-	BUILD_BUG_ON((NR_CPUS/32 * 9) > (PAGE_SIZE-1));
-
 	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
 		return 0;
 
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 383684e30f12..81f145e0c742 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -12,6 +12,7 @@
 #include <linux/bitmap.h>
 #include <linux/atomic.h>
 #include <linux/bug.h>
+#include <asm/page.h>
 
 /* Don't assign or return these: may not be this big! */
 typedef struct cpumask { DECLARE_BITMAP(bits, NR_CPUS); } cpumask_t;
@@ -924,6 +925,11 @@ static inline const struct cpumask *get_cpu_mask(unsigned int cpu)
 static inline ssize_t
 cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
 {
+	/*
+	 * 32bits requires 9bytes: "ff,ffffffff", thus, too many CPUs will
+	 * cause the overflow of sysfs pagebuf
+	 */
+	BUILD_BUG_ON((NR_CPUS/32 * 9) > (PAGE_SIZE-1));
 	return bitmap_print_to_pagebuf(list, buf, cpumask_bits(mask),
 				      nr_cpu_ids);
 }
-- 
2.25.1

Thanks
Barry
