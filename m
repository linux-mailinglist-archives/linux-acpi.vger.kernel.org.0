Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4AE93C1ACE
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jul 2021 23:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhGHVGh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Jul 2021 17:06:37 -0400
Received: from foss.arm.com ([217.140.110.172]:38282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230238AbhGHVGh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 8 Jul 2021 17:06:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B68C7D6E;
        Thu,  8 Jul 2021 14:03:54 -0700 (PDT)
Received: from bogus (unknown [10.57.79.183])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23C8A3F73B;
        Thu,  8 Jul 2021 14:03:52 -0700 (PDT)
Date:   Thu, 8 Jul 2021 22:03:09 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 01/13] mailbox: pcc: Fix doxygen comments
Message-ID: <20210708210309.gibsd4lou63x2ar5@bogus>
References: <20210708180851.2311192-1-sudeep.holla@arm.com>
 <20210708180851.2311192-2-sudeep.holla@arm.com>
 <889de6fc8688edc0f846448b94af299709fa65b8.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <889de6fc8688edc0f846448b94af299709fa65b8.camel@perches.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 08, 2021 at 11:51:45AM -0700, Joe Perches wrote:
> On Thu, 2021-07-08 at 19:08 +0100, Sudeep Holla wrote:
> > Clang complains about doxygen comments too with W=1 in the build.
> 
> just fyi: it's not a clang message, it's kernel-doc that complains.
> 
> ./scripts/kernel-doc -none drivers/mailbox/pcc.c
>

Ah OK. Thanks for the info. I may have missed to observe this with gcc or
the kernel-doc is not built by default with gcc unlike clang.

-- 
Regards,
Sudeep
