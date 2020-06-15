Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935481F9D7F
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jun 2020 18:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbgFOQcv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 15 Jun 2020 12:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729966AbgFOQcv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Jun 2020 12:32:51 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680B7C061A0E;
        Mon, 15 Jun 2020 09:32:51 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jks2T-0007R0-Dg; Mon, 15 Jun 2020 18:32:49 +0200
Date:   Mon, 15 Jun 2020 18:32:49 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Stephen Berman <stephen.berman@gmx.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
Message-ID: <20200615163249.kofrsl274aotcdz7@linutronix.de>
References: <87imfyh6yx.fsf@gmx.net>
 <87wo4dligz.fsf@gmx.net>
 <20200612110122.jossn5zrktcvpbpm@linutronix.de>
 <87tuzdrgm5.fsf@gmx.net>
 <20200614171005.3zy673p6bpwoqnmq@linutronix.de>
 <874krcsquv.fsf@gmx.net>
 <20200615145130.bcdidqkp6w23xb6c@linutronix.de>
 <87tuzcqqul.fsf@gmx.net>
 <20200615155846.nd5n32qggusakxl7@linutronix.de>
 <87pna0qp2x.fsf@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <87pna0qp2x.fsf@gmx.net>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020-06-15 18:19:18 [+0200], Stephen Berman wrote:
> It's there, 196 lines above the Start ffff8d7aa8758a80 line:
> 
> Jun 15 08:56:58 strobe-jhalfs kernel: [  106.275356] acpi_os_execute(1109) Adding acpi_ev_notify_dispatch+0x0/0x55 ffff8d7aa84e70a0 <ffff8d7aa8758a80>

So compared with 
| [  193.321242] acpi_os_execute_deferred_notify(851) Start  ffff8d7aa8758a80 acpi_ev_notify_dispatch+0x0/0x55(ffff8d7aa84e70a0)

it took ~87 seconds for the item to start since it was enqueued.
Assuming that workqueue still makes progress on shutdown it may just a
long time to flush all worker on shutdown. I still have no idea how the
commit in question is responsible for that behaviour…

> Steve Berman

Sebastian
