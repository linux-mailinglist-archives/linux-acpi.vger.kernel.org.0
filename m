Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A57E2C9266
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Dec 2020 00:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgK3XUX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Nov 2020 18:20:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51612 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgK3XUX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Nov 2020 18:20:23 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606778380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qxHsKSfHHXQueGroD51dRhejuAdPNyV7Q/W8lJ8mkc0=;
        b=yHrJoZR8A3N8X4zK4K5584vD486MgEzCUAlvrxzaGLasgm4/oKFLQEwAQnbBzQPJ8uvUzi
        cwVafkpLiHR0DcIasYTwvbNbhQhPAUt6NeDBRcZrjQ0Kwet/iLrCnbwAZn6MKD/5wea/AN
        3PafQz5fVu7bKR34Fz2f+AhtJShGNKw1NhYBcedUxhHvVE65qR2FLBU9tkh8btU79O9ng6
        iE+SBVHk9P8PErOTLzwr6UBkFjXpgz9ENcGYf5nd2rLF4e4CCJVppDFhJmnoz/iLx3klIf
        s9O7C4vwf7NyoymLn/QHwAahuyiTzdKmfiWsXbBx+8lxeQV6ny9Qd0AgOPkfBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606778380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qxHsKSfHHXQueGroD51dRhejuAdPNyV7Q/W8lJ8mkc0=;
        b=5roGyYrsSogIsR3PCkM0rkyQKqDZVbrr7/PvcnkChlPJZSj0Pk+o902lCFGtFzJiXbUIWO
        GJJHGIJxA7PRMvBw==
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, lenb@kernel.org, rjw@rjwysocki.net,
        gregkh@linuxfoundation.org, maz@kernel.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, linux-acpi@vger.kernel.org, dwagner@suse.de,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v4 1/5] genirq/affinity: Add irq_update_affinity_desc()
In-Reply-To: <1606757759-6076-2-git-send-email-john.garry@huawei.com>
References: <1606757759-6076-1-git-send-email-john.garry@huawei.com> <1606757759-6076-2-git-send-email-john.garry@huawei.com>
Date:   Tue, 01 Dec 2020 00:19:40 +0100
Message-ID: <87y2iih1pv.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Dec 01 2020 at 01:35, John Garry wrote:

> Add a function to allow the affinity of an interrupt be switched to
> managed, such that interrupts allocated for platform devices may be
> managed.

Could you please add a paragraph which explains the limitations of that
interface?

> +/**
> + * irq_update_affinity_desc - Update affinity management for an interrupt
> + * @irq:	The interrupt number to update
> + * @affinity:	Pointer to the affinity descriptor
> + *
> + * This interface can be used to configure the affinity management of
> + * interrupts which have been allocated already.

Same here.

Thanks,

        tglx
