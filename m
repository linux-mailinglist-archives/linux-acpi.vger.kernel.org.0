Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905F2428A98
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Oct 2021 12:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbhJKKMf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Oct 2021 06:12:35 -0400
Received: from foss.arm.com ([217.140.110.172]:42498 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235726AbhJKKMf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Oct 2021 06:12:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97EB41FB;
        Mon, 11 Oct 2021 03:10:35 -0700 (PDT)
Received: from bogus (unknown [10.57.21.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37ECE3F66F;
        Mon, 11 Oct 2021 03:10:34 -0700 (PDT)
Date:   Mon, 11 Oct 2021 11:09:49 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 00/14] mailbox: pcc: Add support for PCCT extended PCC
 subspaces
Message-ID: <20211011100949.4ck26vos5apts45e@bogus>
References: <20210917133357.1911092-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917133357.1911092-1-sudeep.holla@arm.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jassi,

On Fri, Sep 17, 2021 at 02:33:43PM +0100, Sudeep Holla wrote:
> Hi,
> 
> Though the series is about adding support for PCCT extended PCC subspaces,
> except one patch, remaining are either preparatory or clean up to add
> the PCCT extended PCC subspaces. Only patch 12 adds the support of extended
> PCC type3/4 subspaces.
> 
> The main change affecting your is the change in pcc_mbox_request_channel
> to avoid clien driver using con_priv member which is designed for controller
> private pointer rather than for client's to use that.
> 

Once I have ack from Guenter, is it OK to get this merged via mailbox tree.
Rafael is happy for me to maintain this PCC part of ACPI. Do you prefer
to merge patches directly or do you prefer pull request ? Let me know.

-- 
Regards,
Sudeep
