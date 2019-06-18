Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9124C4A42B
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2019 16:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbfFROk1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 Jun 2019 10:40:27 -0400
Received: from foss.arm.com ([217.140.110.172]:44364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729038AbfFROk1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Jun 2019 10:40:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50E012B;
        Tue, 18 Jun 2019 07:40:26 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3124C3F718;
        Tue, 18 Jun 2019 07:40:25 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] ACPI/PPTT: Add support for ACPI 6.3 thread flag
To:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
        sudeep.holla@arm.com, lenb@kernel.org
References: <20190614223158.49575-1-jeremy.linton@arm.com>
 <20190614223158.49575-2-jeremy.linton@arm.com>
 <667f95c0-5aa9-f460-a49a-e6dfefc027d8@arm.com>
 <2d1b547f-f9ee-391c-c4f3-0232a08a86bc@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <718438d0-8648-897a-83e8-801146a0af86@arm.com>
Date:   Tue, 18 Jun 2019 15:40:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <2d1b547f-f9ee-391c-c4f3-0232a08a86bc@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 18/06/2019 15:21, Jeremy Linton wrote:
[...]
>>> + * Return: -ENOENT if the PPTT doesn't exist, the CPU cannot be found or
>>> + *       the table revision isn't new enough.
>>> + * Otherwise returns flag value
>>> + */
>>
>> Nit: strictly speaking we're not returning the flag value but its mask
>> applied to the flags field. I don't think anyone will care about getting
>> the actual flag value, but it should be made obvious in the doc:
> 
> Or I clarify the code to actually do what the comments says. Maybe that is what John G was also pointing out too?
> 

Mmm I didn't find any reply from John regarding this in v1, but I wouldn't
mind either way, as long as the doc & code are aligned.

[...]
