Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD383C8B49
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jul 2021 20:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhGNSzN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Jul 2021 14:55:13 -0400
Received: from foss.arm.com ([217.140.110.172]:38422 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhGNSzM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Jul 2021 14:55:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23136D6E;
        Wed, 14 Jul 2021 11:52:20 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 417A83F774;
        Wed, 14 Jul 2021 11:52:19 -0700 (PDT)
Date:   Wed, 14 Jul 2021 19:52:16 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 12/13] mailbox: pcc: Add support for PCCT extended PCC
 subspaces(type 3/4)
Message-ID: <20210714185216.GE49078@e120937-lin>
References: <20210708180851.2311192-1-sudeep.holla@arm.com>
 <20210708180851.2311192-13-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708180851.2311192-13-sudeep.holla@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 08, 2021 at 07:08:50PM +0100, Sudeep Holla wrote:
> With all the plumbing in place to avoid accessing PCCT type and other
> fields directly from the PCCT table all the time, let us now add the
> support for extended PCC subspaces(type 3 and 4).
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---

Hi Sudeep,

just a few general observation on Type 3/4 subspaces from the spec
Table 14.7:

- "If a slave-subspace is present in the PCCT, then the platform interrupt flag must be set to 1." table 14.7

  Maybe is worth to WARN on this if this assumption is violated by the
  ACPI table we found.

- "Note that if interrupts are edge triggered, then each subspace must have its own unique interrupt."

  Same here, maybe it's worth also to check this, so that after all the
  pchan->db_irq has been obtained no edge triggered irqs are duplicated
  before requesting them.

Thanks,
Cristian
