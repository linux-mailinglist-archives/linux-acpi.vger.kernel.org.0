Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6DC135628
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2020 10:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbgAIJug (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Jan 2020 04:50:36 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57344 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729170AbgAIJug (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 9 Jan 2020 04:50:36 -0500
Received: from zn.tnic (p200300EC2F0C570015F413FA3C3D5197.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:5700:15f4:13fa:3c3d:5197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 66F181EC027B;
        Thu,  9 Jan 2020 10:50:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578563434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=y7mS9NnPD6OSBPhSJx5wYgWB9ewIEygpgYvrQyTTXpg=;
        b=aVUfb17dyKJyuFU8Zez9HoBXS6G3MDvdXudnzYReDxY8Bsyq0XWU8zAwWM5Pm/UEAzetZG
        7gAHaVnyo1MgHOlVUjv9nuYuUO4VfZdu6R6Q7XoRXvs94lJ08hEOo1G2+Q+8kekhLSzlzS
        +g2enexNNuz+AT1l5Rcxz4VAMTdL6CM=
Date:   Thu, 9 Jan 2020 10:50:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Bhaskar Upadhaya <bupadhaya@marvell.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, lenb@kernel.org, rafael@kernel.org,
        gkulkarni@marvell.com, rrichter@marvell.com,
        bhaskar.upadhaya.linux@gmail.com
Subject: Re: [PATCH V2] apei/ghes: fix ghes_poll_func by registering in
 non-deferrable mode
Message-ID: <20200109095026.GA5603@zn.tnic>
References: <1578503858-27853-1-git-send-email-bupadhaya@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1578503858-27853-1-git-send-email-bupadhaya@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jan 08, 2020 at 09:17:38AM -0800, Bhaskar Upadhaya wrote:
> Currently Linux register ghes_poll_func with TIMER_DEFERRABLE flag,
> because of which it is serviced when the CPU eventually wakes up with a
> subsequent non-deferrable timer and not at the configured polling interval.
> 
> For polling mode, the polling interval configured by firmware should not
> be exceeded as per ACPI_6_3 spec[refer Table 18-394], So Timer need to
> be configured in non-deferrable mode by removing TIMER_DEFERRABLE flag.
> With NO_HZ enabled and timer callback being configured in non-deferrable
> mode, timer callback will get called exactly after polling interval.
> 
> Definition of poll interval as per spec (referred ACPI 6.3):
> "Indicates the poll interval in milliseconds OSPM should use to
> periodically check the error source for the presence of an error
> condition"
> 
> We are observing an issue in our ThunderX2 platforms wherein
> ghes_poll_func is not called within poll interval when timer is
> configured with TIMER_DEFERRABLE flag(For NO_HZ kernel) and hence
> we are losing the error records.
> 
> Impact of removing TIMER_DEFFERABLE flag
> - With NO_HZ enabled, additional timer ticks and unnecessary wakeups of
>  the cpu happens exactly after polling interval.
> 
> - If polling interval is too small than polling function will be called
>  too frequently which may stall the cpu.

If that becomes a problem, the polling interval setting should be fixed
to filter too small values.

Anyway, I went and streamlined your commit message:

    apei/ghes: Do not delay GHES polling

    Currently, the ghes_poll_func() timer callback is registered with the
    TIMER_DEFERRABLE flag. Thus, it is run when the CPU eventually wakes
    up together with a subsequent non-deferrable timer and not at the precisely
    configured polling interval.

    For polling mode, the polling interval configured by firmware should not
    be exceeded according to the ACPI spec 6.3, Table 18-394. The definition
    of the polling interval is:

    "Indicates the poll interval in milliseconds OSPM should use to
    periodically check the error source for the presence of an error
    condition."

    If this interval is extended due to the timer callback deferring, error
    records can get lost. Which we are observing on our ThunderX2 platforms.

    Therefore, remove the TIMER_DEFERRABLE flag so that the timer callback
    executes at the precise interval.

and made it more readable, hopefully.

Rafael, pls fixup when applying.

With that:

Acked-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
