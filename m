Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2619A2CA9A0
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Dec 2020 18:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgLAR2x (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Dec 2020 12:28:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56782 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgLAR2x (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Dec 2020 12:28:53 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606843691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=27ELMoHJXn3b8+hiqsrg9icIzbuPOs5y3FOlQUsqIB4=;
        b=cWQpemZ9a8kYbaab9vBsrF70DINP/sl7/f536Z967AZUolItnvqS+Rna1p+C+P4ZuzA2RV
        nMcN9Vk7VL3DkpMeX6IKyDSIoy4XrmQRr8MqSSkNek4YQVmJn/BB3cVfkWENovAqEiaZVd
        TGsAaj0/Dbejlotam3E50tZlCu2cANP0dgfvu/2BPoM9E1A152PyIv2piLVPI01TpxtpGd
        7PLg3aKf7+EigclyQn5WNC0JOyLrHKUqrKrIdwyqlglFTyl+kFJoNF3BEYvsNhfLcYvLAT
        6c2Zs+sHe17eErelFMTtQDoDWk+fxyQ46zNIJI3n7xin7+9ZqV/n7hJZKKeZcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606843691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=27ELMoHJXn3b8+hiqsrg9icIzbuPOs5y3FOlQUsqIB4=;
        b=Nux9htAOFg3I46sIoyYEyXO8aK0gYSHbKoJ1s9kXYsRo4VvFd/2RkgaLkF9b1UceOUt6Fc
        MWQAmeay6zHUoRAg==
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, lenb@kernel.org, rjw@rjwysocki.net,
        gregkh@linuxfoundation.org, maz@kernel.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, linux-acpi@vger.kernel.org, dwagner@suse.de
Subject: Re: [PATCH v4 1/5] genirq/affinity: Add irq_update_affinity_desc()
In-Reply-To: <22315d74-0696-85ef-882c-85961cfb4f32@huawei.com>
References: <1606757759-6076-1-git-send-email-john.garry@huawei.com> <1606757759-6076-2-git-send-email-john.garry@huawei.com> <87y2iih1pv.fsf@nanos.tec.linutronix.de> <22315d74-0696-85ef-882c-85961cfb4f32@huawei.com>
Date:   Tue, 01 Dec 2020 18:28:10 +0100
Message-ID: <87pn3tfnbp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Dec 01 2020 at 15:22, John Garry wrote:
> /*
>   * There are certain limitations on when it may be used - attempts to 
> use it for when the kernel is configured for generic IRQ reservation 
> mode (in config GENERIC_IRQ_RESERVATION_MODE) will fail, as it may 
> conflict with managed/non-managed interrupt accounting. In addition, 
> attempts to use it on an interrupt which is already started or which has 
> already been configured as managed will also fail, as these mean invalid 
> init state or double init.
>
> ...
>
> Let me know if not good, if not I'll post again soon.

LGTM
