Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E3338075B
	for <lists+linux-acpi@lfdr.de>; Fri, 14 May 2021 12:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbhENKgh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 May 2021 06:36:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233569AbhENKgR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 May 2021 06:36:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BF2F613B5;
        Fri, 14 May 2021 10:35:04 +0000 (UTC)
Date:   Fri, 14 May 2021 11:35:02 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] arm64, topology: enable use of
 init_cpu_capacity_cppc()
Message-ID: <20210514103502.GB855@arm.com>
References: <20210514095339.12979-1-ionela.voinescu@arm.com>
 <20210514095339.12979-4-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514095339.12979-4-ionela.voinescu@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 14, 2021 at 10:53:39AM +0100, Ionela Voinescu wrote:
> Now that the arch topology driver provides a method of setting CPU
> capacity values based on information on highest performance from CPPC,
> use this functionality on arm64 platforms.
> 
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
