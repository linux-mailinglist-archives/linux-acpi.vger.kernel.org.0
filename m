Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBA7B19C884
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Apr 2020 20:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389072AbgDBSHI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Apr 2020 14:07:08 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49725 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbgDBSHH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Apr 2020 14:07:07 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 754a245cf567c245; Thu, 2 Apr 2020 20:07:06 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: OOB access on ACPI processor thermal device via sysfs write
Date:   Thu, 02 Apr 2020 20:07:05 +0200
Message-ID: <1971976.2hYWdNQAa4@kreacher>
In-Reply-To: <0926f44775e91145a83c9eb88a468c64261af20d.camel@intel.com>
References: <s5h5zeiwd01.wl-tiwai@suse.de> <s5h1rp6w97p.wl-tiwai@suse.de> <0926f44775e91145a83c9eb88a468c64261af20d.camel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thursday, April 2, 2020 12:03:30 PM CEST Zhang Rui wrote:
> On Thu, 2020-04-02 at 11:03 +0200, Takashi Iwai wrote:
> > On Thu, 02 Apr 2020 09:47:50 +0200,
> > Zhang, Rui wrote:
> > > 
> > > CC Viresh.
> > > 
> > > Yes, I've received it.
> > > 
> > > To me, there is not a hard rule that the cooling device max_state
> > > must be static.
> > > We should be able to detect the max_state change and reset the
> > > stats table when necessary.
> > > 
> > > I just finished a prototype patch to do so, and will paste it
> > > later.
> > 
> > Great, that sounds like a feasible option, indeed.
> > 
> > 
> Please try the patch below and see if the problem goes away or not.
> 
> From 7b429674a0e1a6226734c8919b876bb57d946b1d Mon Sep 17 00:00:00 2001
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Thu, 2 Apr 2020 11:18:44 +0800
> Subject: [RFC PATCH] thermal: update thermal stats table when max cooling
>  state changed
> 
> The maximum cooling state of a cooling device may be changed at
> runtime. Thus the statistics table must be updated to handle the real
> maximum cooling states supported.
> 
> This fixes an OOB issue when updating the statistics of the processor
> cooling device, because it only supports 1 cooling state before cpufreq
> driver loaded.

It might also be addressed by adding a ->get_state_count() callback to
struct thermal_cooling_device_ops (and fall back to ->get_max_state() if
that is NULL) and use that for the stats allocation.

If the new callback always returns CPUFREQ_THERMAL_MAX_STEP, the size of the
stats table will be sufficient in all cases and acpi_processor_notifier()
can update it as needed.



