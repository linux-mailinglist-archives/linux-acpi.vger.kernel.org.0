Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133A824FF17
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Aug 2020 15:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgHXNkP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Aug 2020 09:40:15 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41294 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgHXNil (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Aug 2020 09:38:41 -0400
Received: from 89-64-88-199.dynamic.chello.pl (89.64.88.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.459)
 id 650310ffad508e13; Mon, 24 Aug 2020 15:38:39 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM: sleep: core: Fix the handling of pending runtime resume requests
Date:   Mon, 24 Aug 2020 15:38:39 +0200
Message-ID: <2486532.D7zGhtygOF@kreacher>
In-Reply-To: <20200824083452.GX1375436@lahna.fi.intel.com>
References: <7969920.MVx1BpXlEM@kreacher> <20200821193442.GA264863@rowland.harvard.edu> <20200824083452.GX1375436@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Monday, August 24, 2020 10:34:52 AM CEST Mika Westerberg wrote:
> Hi,
> 
> On Fri, Aug 21, 2020 at 03:34:42PM -0400, Alan Stern wrote:
> > This means that the code could be simplified to just:
> > 
> > 	pm_runtime_barrier(dev);
> > 
> > Will this fix the reported bug?  It seems likely to me that the actual 
> > problem with the failure scenario in the patch description was that 
> > turning on an ACPI power resource causes runtime-resume requests to be 
> > queued for all devices sharing that resource.  Wouldn't it make more 
> > sense to resume only the device that requested it and leave the others 
> > in runtime suspend?
> 
> The problem with at least PCIe devices that share ACPI power resources
> is that once you turn on the power resource all the devices that shared
> it will go into D0uninitialized power state and that means they lose all
> wake configuration etc. so they need to be re-initialized by their
> driver before they can go back to D3(cold) in order for their wakes to
> still work.

Plus devices in D0uninitialized may prevent the SoC from allowing package
C-states to be used for the processor AFAICS.

BTW, does the patch make the issue at hand go away?



