Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1182E6CA0
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Dec 2020 00:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgL1Xz4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Dec 2020 18:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbgL1Xz4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Dec 2020 18:55:56 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22063C061796;
        Mon, 28 Dec 2020 15:55:16 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id w6so7121749pfu.1;
        Mon, 28 Dec 2020 15:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vMXcPyqogv+uoJYzhVOVnDAaZJOmErDohwQ6l3V0Tbg=;
        b=RCwxzjHgHRywdIjnZhfHqWQT88k6zkvKX7/pgZLdGjNj/hqXpZSJxxHzpffIWF/YMP
         MsAk01fhCsjBD2lJKQN3JYTB0LhDDy8S7pzJgUJwoDB38B2a0/CXPDr+DQ0aZLNu8UAr
         SrF5DqcHUQIGz+0z99sqk8sp/Y/2dlCvdJKiVV+gGTkX4qkrLyykJ69L2WoZk/K7kwxb
         vpU9/c5vHcBp9iRzwduHRTwayvWriDXBf0Amif2B14KYNOTr/XAR0M1hwY5XMjJiLRP2
         eOZyRQynCBNuXz1oXtWtXJqG90WDqHNpICCyiHzhNBeU4tSBHr9i0j337HXoxKzV3Gp3
         /HEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vMXcPyqogv+uoJYzhVOVnDAaZJOmErDohwQ6l3V0Tbg=;
        b=QTMmWjjON/n78wUSikhwJ62cFunaKZCqKsuBrSVO4j1PPduMqi/1WWb8cW2nbaOclF
         56p1Ki/kn9xxhBjTpdo/BO9Hw9tx0fJxBkQMnxxX5ReSbcN1oHfs6Mr9E+Le2Dbwxrh3
         CskM8+sLGSTahkjnfdCJEwE02YyAYMSRTyrcpUVbAeKHPdHgbDHqH35qfxJxFU9oA7GJ
         PcRNPG78yOxZlFYpIOjZlAU5L943/3hgpYNM/Ml+xgOV4fcqGq/yjJG1wsP8kPgBo8q7
         /cFmlBg6PZ5WO+CWkI8T7aMsI44lQbhdPe0Km1qzIijEVL0E4VEiKQ5vKR/UAaKL7bPe
         n0Vg==
X-Gm-Message-State: AOAM533F/8H25IFV7lUAo8s8lfQFB5GqPnbnUa6a0bVO2pNJMLDIBeRB
        XBc1Fp2NljXBM9LrYsIEpQU+bv4N286qFsw2Rw8=
X-Google-Smtp-Source: ABdhPJxcIpwrhXTCnpSHYMrG7oyN/71F7WSecxf2mRW4vD9HklVZpmkRH89e6+SPSny/u87BGg+x3d2aAuPAG0PAwpc=
X-Received: by 2002:a05:6a00:170a:b029:19d:afca:4704 with SMTP id
 h10-20020a056a00170ab029019dafca4704mr21836791pfc.7.1609199715686; Mon, 28
 Dec 2020 15:55:15 -0800 (PST)
MIME-Version: 1.0
References: <20201224010907.263125-1-djrscally@gmail.com> <20201224010907.263125-15-djrscally@gmail.com>
 <CAHp75VeXN6PnV7Mzz6UMpD+m-yjPi6XK0kx1=+-M5mci=Vb=YQ@mail.gmail.com>
 <20201228170521.GZ26370@paasikivi.fi.intel.com> <2d37df3d-f04c-6679-6e27-6c7f82e9b158@gmail.com>
 <20201228225544.GH4077@smile.fi.intel.com> <X+plTyUFhfHi7eIE@pendragon.ideasonboard.com>
In-Reply-To: <X+plTyUFhfHi7eIE@pendragon.ideasonboard.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 29 Dec 2020 01:54:59 +0200
Message-ID: <CAHp75Vdzk7i+QzkTxLJUUkw3xZot9F7QT8pyu6b5yjkCVzMXEA@mail.gmail.com>
Subject: Re: [PATCH v3 14/14] ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@acpica.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tian Shu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        kieran.bingham+renesas@ideasonboard.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        niklas.soderlund+renesas@ragnatech.se,
        Steve Longerbeam <slongerbeam@gmail.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jordan Hand <jorhand@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Dec 29, 2020 at 1:08 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Tue, Dec 29, 2020 at 12:55:44AM +0200, Andy Shevchenko wrote:
> > On Mon, Dec 28, 2020 at 10:37:38PM +0000, Daniel Scally wrote:
> > > On 28/12/2020 17:05, Sakari Ailus wrote:

...

> > > Which do you prefer?
> >
> > Actually ipu3-cio2.h misses a lot of inclusions (like mutex.h which I
> > immediately noticed when scrolled over data types).
>
> Then ipu3-cio2.h should be fixed :-)

Below is a draft patch (it is possible mangled, due to Gmail). Can you
look at it and tell me what you think?
I believe some headers can be removed, but I have no idea about header
inclusion guarantees that v4l2 provides.

From 10fa6c7ff66ded35a246677ffe20c677e8453f5b3 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 29 Dec 2020 01:42:03 +0200
Subject: [PATCH 1/1] media: ipu3-cio2: Add headers that ipu3-cio2.h is direct
 user of

Add headers that ipu3-cio2.h is direct user of.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/pci/intel/ipu3/ipu3-cio2.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.h
b/drivers/media/pci/intel/ipu3/ipu3-cio2.h
index ccf0b85ae36f..9ea154c50ba1 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2.h
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.h
@@ -4,8 +4,25 @@
 #ifndef __IPU3_CIO2_H
 #define __IPU3_CIO2_H

+#include <linux/bits.h>
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
+#include <linux/mutex.h>
 #include <linux/types.h>

+#include <asm/page.h>
+
+#include <linux/videodev2.h>
+
+#include <media/media-device.h>
+#include <media/media-entity.h>
+#include <media/v4l2-async.h>
+#include <media/v4l2-dev.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-subdev.h>
+#include <media/videobuf2-core.h>
+#include <media/videobuf2-v4l2.h>
+
 #define CIO2_NAME "ipu3-cio2"
 #define CIO2_DEVICE_NAME "Intel IPU3 CIO2"
 #define CIO2_ENTITY_NAME "ipu3-csi2"
@@ -325,6 +342,8 @@ struct csi2_bus_info {
  u32 lanes;
 };

+struct cio2_fbpt_entry;
+
 struct cio2_queue {
  /* mutex to be used by vb2_queue */
  struct mutex lock;
@@ -355,6 +374,8 @@ struct cio2_queue {
  atomic_t bufs_queued;
 };

+struct pci_dev;
+
 struct cio2_device {
  struct pci_dev *pci_dev;
  void __iomem *base;
-- 
2.29.2


-- 
With Best Regards,
Andy Shevchenko
