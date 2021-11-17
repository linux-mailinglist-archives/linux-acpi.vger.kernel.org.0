Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D534548F7
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Nov 2021 15:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237588AbhKQOle (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Nov 2021 09:41:34 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:7264 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237969AbhKQOlc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 Nov 2021 09:41:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637159914; x=1668695914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=18LVmedV4Z42EC0Yv7DHkbPVv6n/gFAqTZvDjB6byGU=;
  b=sMb0uhBm9WaokxhArrOMJXWWZxtKDjNu3+q39HRbzT02XYQHoMkE7vI2
   YR28ySGlsbrJ16klmWO2o9N75JNFefRkzYDg6iNVl58T64R8BG/LsKja/
   CL09e97OFCRU+teBlJblEawhb0pap0F9jAJqDCETOLYQ91JHHX26zKLni
   4=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 17 Nov 2021 06:38:31 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 06:38:31 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 17 Nov 2021 06:38:31 -0800
Received: from fixkernel.fios-router.home (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 17 Nov 2021 06:38:30 -0800
Date:   Wed, 17 Nov 2021 09:38:28 -0500
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] software node: Skip duplicated software_node sysfs
Message-ID: <YZUT5EPqPiPy2iiy@fixkernel.fios-router.home>
References: <20211101200346.16466-1-quic_qiancai@quicinc.com>
 <CAHp75VcrWPdR8EVGpcsniQedT0J4X700N7thFs6+srTP1MTgwQ@mail.gmail.com>
 <52df4a97-1132-d594-0180-132d0ca714d5@quicinc.com>
 <CAHp75VebOnrce-XZjOnZiivQPz-Cdgq6mor5oiLxK8Y49GiNNg@mail.gmail.com>
 <YZMrjqhYYNGMP84x@qian-HP-Z2-SFF-G5-Workstation>
 <CAJZ5v0hjq+X=Gej072jwY2Uf4BgvqPHvHTON2p0Mszd5ntjjJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hjq+X=Gej072jwY2Uf4BgvqPHvHTON2p0Mszd5ntjjJA@mail.gmail.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 16, 2021 at 05:29:56PM +0100, Rafael J. Wysocki wrote:
> > Frist, fixes all dev->fwnode / dev.fwnode to use dev_fwnode(). This
> > could be a standalone tree-wide patchset going out to avoid
> > heavy-lifting later.
> >
> > Then, we can create another patchset on top. I have audited
> > "irq_domain" but not seen any "secondary" leakage. Struct
> > "cht_int33fe_data" does have some need to fix.
> >
> > Rename set_secondary_fwnode() to insert_secondary_fwnode(). Fix things
> > in drivers/base/core.c, swnode.c etc to use the new fwnode_head and
> > anything I can't think of right now.
> >
> > Since we will have multiple "software_node" (secondary fwnode:s) for a
> > single "device". What would be the usual way to deal with a
> > linked-list in the sysfs? I can think of just let "software_node"
> > become a directory to host a list of symlinks named from
> > swnode->id. Thoughts?
> 
> Note that one pointer dereference in ACPI_COMPANION() is enough.

Rafael, we suppose to convert ACPI_COMPANION() to:

to_acpi_device_node(dev_fwnode())

since we will no longer has a dev->fwnode pointer anymore. Do you
suggest to keep that pointer but convert the "secondary" to a linked
list instead?
