Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C7A4865DA
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jan 2022 15:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239980AbiAFOMp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jan 2022 09:12:45 -0500
Received: from foss.arm.com ([217.140.110.172]:54802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239860AbiAFOMp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 6 Jan 2022 09:12:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE35A1042;
        Thu,  6 Jan 2022 06:12:44 -0800 (PST)
Received: from bogus (unknown [10.57.38.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 027E43F5A1;
        Thu,  6 Jan 2022 06:12:43 -0800 (PST)
Date:   Thu, 6 Jan 2022 14:12:30 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, kbuild-all@lists.01.org
Subject: Re: [RFC PATCH] ACPI: PCC: pcc_ctx can be static
Message-ID: <20220106141230.qddcwyycefxlbrma@bogus>
References: <20220103155838.616580-1-sudeep.holla@arm.com>
 <20220105174554.GA29945@1e936cf764ba>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105174554.GA29945@1e936cf764ba>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On Thu, Jan 06, 2022 at 01:45:56AM +0800, kernel test robot wrote:
> drivers/acpi/acpi_pcc.c:34:22: warning: symbol 'pcc_ctx' was not declared. Should it be static?
>
> Reported-by: kernel test robot <lkp@intel.com>

Thanks for the fix and sorry for not noticing this before it was merged.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
