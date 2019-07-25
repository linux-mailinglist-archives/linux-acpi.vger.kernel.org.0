Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACF3074E68
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Jul 2019 14:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388953AbfGYMo5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Jul 2019 08:44:57 -0400
Received: from foss.arm.com ([217.140.110.172]:56556 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387824AbfGYMo5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Jul 2019 08:44:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D83E152D;
        Thu, 25 Jul 2019 05:44:55 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4BAB3F71F;
        Thu, 25 Jul 2019 05:44:53 -0700 (PDT)
Subject: Re: [PATCH v1] ACPI / APEI: Get rid of NULL_UUID_LE constant
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Christoph Hellwig <hch@lst.de>
References: <20190717105543.76244-1-andriy.shevchenko@linux.intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <c203f51b-3bf0-441a-1c5e-a9adf1e86ec5@arm.com>
Date:   Thu, 25 Jul 2019 13:44:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190717105543.76244-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 17/07/2019 11:55, Andy Shevchenko wrote:
> This is a missed part of the commit 5b53696a30d5
> ("ACPI / APEI: Switch to use new generic UUID API"), i.e.
> replacing old definition with a global constant variable.

Reviewed-by: James Morse <james.morse@arm.com>

Thanks,

James
