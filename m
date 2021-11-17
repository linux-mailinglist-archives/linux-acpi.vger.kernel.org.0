Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BE7454AB9
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Nov 2021 17:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbhKQQQj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Nov 2021 11:16:39 -0500
Received: from smtprelay0023.hostedemail.com ([216.40.44.23]:40062 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232707AbhKQQQj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 Nov 2021 11:16:39 -0500
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Nov 2021 11:16:39 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave07.hostedemail.com (Postfix) with ESMTP id 5D121183F96DE
        for <linux-acpi@vger.kernel.org>; Wed, 17 Nov 2021 16:05:31 +0000 (UTC)
Received: from omf16.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 942031822325F;
        Wed, 17 Nov 2021 16:05:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id E71D452A;
        Wed, 17 Nov 2021 16:05:23 +0000 (UTC)
Message-ID: <cf7ad8715a02f3a0e4fe0cd8a270585dcf84bb3a.camel@perches.com>
Subject: Re: [PATCH v9 5/5] MAINTAINERS: Add maintainer for xilinx-ams
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Anand Ashok Dumbre <ANANDASH@xilinx.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        git <git@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>
Date:   Wed, 17 Nov 2021 08:05:24 -0800
In-Reply-To: <CAHp75VdaO4+DxMn2eJx7t0_UFgrHGV2vgzXvRB=qwZi-ZpMaOA@mail.gmail.com>
References: <20211116150842.1051-1-anand.ashok.dumbre@xilinx.com>
         <20211116150842.1051-6-anand.ashok.dumbre@xilinx.com>
         <YZPtW5igA8RBYLWv@smile.fi.intel.com>
         <BY5PR02MB69168A6537474DF8948C3D0BA99A9@BY5PR02MB6916.namprd02.prod.outlook.com>
         <CAHp75VdaO4+DxMn2eJx7t0_UFgrHGV2vgzXvRB=qwZi-ZpMaOA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E71D452A
X-Spam-Status: No, score=-3.40
X-Stat-Signature: ami9yzewngpqq7kik7kaad5pw1e1qt3u
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX182X4RekMTMr80iwuE0NqYUf3L6LFeosFM=
X-HE-Tag: 1637165123-216991
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 2021-11-17 at 17:17 +0200, Andy Shevchenko wrote:
> On Wed, Nov 17, 2021 at 5:00 PM Anand Ashok Dumbre <ANANDASH@xilinx.com> wrote:
> > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Sent: Tuesday 16 November 2021 5:42 PM
> > > On Tue, Nov 16, 2021 at 03:08:42PM +0000, Anand Ashok Dumbre wrote:
> > > > Add maintaner entry for xilinx-ams driver.
> > > 
> > > Have you run checkpatch?
> > 
> > Yes I did.
> > I don't see any error on this.
> 
> Hmm... Perhaps it needs an unobvious parameter?
> Joe, X is definitely after M, any idea why checkpatch hasn't caught this up?

[]

This is the suggested patch below right?
https://lore.kernel.org/lkml/20211116150842.1051-6-anand.ashok.dumbre@xilinx.com/

It looks OK to me.
What do you think checkpatch is supposed to find?
---
diff --git a/MAINTAINERS b/MAINTAINERS
index dcc1819ec84b..30de0ea64ac4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20640,6 +20640,13 @@ M:	Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
 S:	Maintained
 F:	drivers/net/ethernet/xilinx/xilinx_axienet*
 
+XILINX AMS DRIVER
+M:	Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
+F:	drivers/iio/adc/xilinx-ams.c
+
 XILINX CAN DRIVER
 M:	Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
 R:	Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
-- 
2.17.1



