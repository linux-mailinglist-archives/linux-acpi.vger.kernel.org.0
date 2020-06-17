Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BEA1FCF81
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jun 2020 16:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgFQO1l (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Jun 2020 10:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFQO1k (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Jun 2020 10:27:40 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2E5C06174E;
        Wed, 17 Jun 2020 07:27:40 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jlZ2M-0002bW-7s; Wed, 17 Jun 2020 16:27:34 +0200
Date:   Wed, 17 Jun 2020 16:27:34 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Stephen Berman <stephen.berman@gmx.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
Message-ID: <20200617142734.mxwfoblufmo6li5e@linutronix.de>
References: <20200612110122.jossn5zrktcvpbpm@linutronix.de>
 <87tuzdrgm5.fsf@gmx.net>
 <20200614171005.3zy673p6bpwoqnmq@linutronix.de>
 <874krcsquv.fsf@gmx.net>
 <20200615145130.bcdidqkp6w23xb6c@linutronix.de>
 <87tuzbh482.fsf@gmx.net>
 <20200616073827.vysntufld3ves666@linutronix.de>
 <87o8pjh1i0.fsf@gmx.net>
 <20200616155501.psduxnisltitodme@linutronix.de>
 <871rmesqkk.fsf@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871rmesqkk.fsf@gmx.net>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020-06-16 22:28:43 [+0200], Stephen Berman wrote:
> Your assessment and predictions are right on the mark!
perfect.

> I'm fine with the thermal.tzp=300 workaround, but it would be good to
> find out why this problem started with commit 6d25be57, if my git
> bisection was correct, or if it wasn't, then at least somewhere between
> 5.1.0 and 5.2.0.  Or can you already deduce why?  If not, I'd be more
> than happy to continue applying any patches or trying any suggestions
> you have, if you want to continue debugging this issue.  In any case,
> thanks for pursuing it to this point.

I have no idea why the commit in question should make any difference.
Could please apply the tracing patch on v5.1 and send the trace?

> Steve Berman

Sebastian
