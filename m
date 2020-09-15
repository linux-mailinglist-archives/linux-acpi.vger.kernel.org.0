Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D9626ABFB
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Sep 2020 20:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgIOSb7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Sep 2020 14:31:59 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54364 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727895AbgIOSb4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 15 Sep 2020 14:31:56 -0400
Received: from zn.tnic (p200300ec2f0e42009474dca2b756bdd4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4200:9474:dca2:b756:bdd4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7BE5F1EC0246;
        Tue, 15 Sep 2020 20:31:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600194711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=x77o73At3Ov0p8rWibLOd93HG8JfU43QR0fdkYUjAlY=;
        b=q1iyu72uhDBKtmTnRKZLZ0RxP6EayFjaqvzZFSqc1a7rEg3nUZNcp6RIGiT8W26l9gsh5M
        TL3P9C5n0R2m3S3qbl1KPEI6+Ub9HKNvehduAfh+QyFWmBaD/+LoDnMq8Ke/8CVq8WL0hL
        SPd5zN0s0XnSt1AzL6zkya810QZzvko=
Date:   Tue, 15 Sep 2020 20:31:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, x86@kernel.org, tony.luck@intel.com,
        lenb@kernel.org, daniel.lezcano@linaro.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
        paulmck@kernel.org, tglx@linutronix.de, naresh.kamboju@linaro.org
Subject: Re: [RFC][PATCH 0/4] Fix up ACPI processor idle vs RCU
Message-ID: <20200915183150.GX14436@zn.tnic>
References: <20200915103157.345404192@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200915103157.345404192@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 15, 2020 at 12:31:57PM +0200, Peter Zijlstra wrote:
> Boris tested an earlier version of these patches and they worked for his
> 32bit Atom board that was triggering complaints.

Want me to test them again?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
