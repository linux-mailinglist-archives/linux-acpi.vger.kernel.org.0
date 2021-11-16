Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9E94528D2
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Nov 2021 04:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbhKPD54 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Nov 2021 22:57:56 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:58639 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236043AbhKPD5y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 15 Nov 2021 22:57:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637034898; x=1668570898;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cJiWH8DuB9KsnVg18puSuj5NIH9G1wk8fKMRlG0VdLM=;
  b=M56mj7gDZ4t8wLbgHUYlJYW+foimgZ+KfZtWW8GVbuYipVdubJ1My6Qg
   CNwSFgLd+QahVKEH0mvrTsD/K2MfMybGcxn3OBuns+8G5R1aYI6ZEpB5y
   47Qd9XX119QFCUPY69mx20owM5Rc1mow/O0MlCp9300ehVlBNF7otCH2P
   U=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Nov 2021 19:54:58 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 19:54:57 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 15 Nov 2021 19:54:57 -0800
Received: from qian-HP-Z2-SFF-G5-Workstation (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 15 Nov 2021 19:54:56 -0800
Date:   Mon, 15 Nov 2021 22:54:54 -0500
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] software node: Skip duplicated software_node sysfs
Message-ID: <YZMrjqhYYNGMP84x@qian-HP-Z2-SFF-G5-Workstation>
References: <20211101200346.16466-1-quic_qiancai@quicinc.com>
 <CAHp75VcrWPdR8EVGpcsniQedT0J4X700N7thFs6+srTP1MTgwQ@mail.gmail.com>
 <52df4a97-1132-d594-0180-132d0ca714d5@quicinc.com>
 <CAHp75VebOnrce-XZjOnZiivQPz-Cdgq6mor5oiLxK8Y49GiNNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHp75VebOnrce-XZjOnZiivQPz-Cdgq6mor5oiLxK8Y49GiNNg@mail.gmail.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 05, 2021 at 09:39:42PM +0200, Andy Shevchenko wrote:
> > Anyway, what's the "upper layer"? Is that "struct device" or "struct
> > swnode"? I suppose you meant:
> 
> struct device here.
> 
> > - Remove "secondary" field from "struct fwnode_handle".
> > - Replace "fwnode" from "upper layer" with
> >   "struct list_head fwnode_head;".
> > - Modify all functions in "software_node_ops" to use "fwnode_head".
> >
> > Is that correct?
> 
> Yes.
> 
> It might be a bit complicated taking into account how much fwnode is
> spreaded in the kernel... Basically, you need to fix all direct
> accesses to the dev->fwnode first.
> Besides that you need to check that fwnode, which is used out of the
> device scope, like in IRQ domains, doesn't use secondary pointer(s).
> 
> This nevertheless adds a lot of flexibility and we may add whatever
> type of fwnodes and mix them together.

Okay, here is my plan until someone still has an idea to avoid a
redesign.

Frist, fixes all dev->fwnode / dev.fwnode to use dev_fwnode(). This
could be a standalone tree-wide patchset going out to avoid
heavy-lifting later.

Then, we can create another patchset on top. I have audited
"irq_domain" but not seen any "secondary" leakage. Struct
"cht_int33fe_data" does have some need to fix.

Rename set_secondary_fwnode() to insert_secondary_fwnode(). Fix things
in drivers/base/core.c, swnode.c etc to use the new fwnode_head and
anything I can't think of right now.

Since we will have multiple "software_node" (secondary fwnode:s) for a
single "device". What would be the usual way to deal with a
linked-list in the sysfs? I can think of just let "software_node"
become a directory to host a list of symlinks named from
swnode->id. Thoughts?
