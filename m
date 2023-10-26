Return-Path: <linux-acpi+bounces-1015-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 183357D82B5
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 14:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCEB9280AAC
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 12:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E682DF94
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 12:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C6DC154
	for <linux-acpi@vger.kernel.org>; Thu, 26 Oct 2023 11:19:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 169591AE;
	Thu, 26 Oct 2023 04:19:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B8D12F4;
	Thu, 26 Oct 2023 04:20:37 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CA653F738;
	Thu, 26 Oct 2023 04:19:50 -0700 (PDT)
Message-ID: <c000f7a3-caeb-4d75-8c88-40ed02950ec1@arm.com>
Date: Thu, 26 Oct 2023 13:19:49 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 6/6] arm64/amu: use capacity_ref_freq to set AMU ratio
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>,
 Ionela Voinescu <ionela.voinescu@arm.com>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 sudeep.holla@arm.com, gregkh@linuxfoundation.org, rafael@kernel.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com, viresh.kumar@linaro.org,
 lenb@kernel.org, robert.moore@intel.com, lukasz.luba@arm.com,
 pierre.gondois@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linuxfoundation.org, conor.dooley@microchip.com,
 suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-7-vincent.guittot@linaro.org>
 <ZTbebQrK3K+JwWxR@arm.com>
 <CAKfTPtA0KBE8TFifOEXddF9d_wqDjb4QUvgK8c0DTtyLrX0atA@mail.gmail.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtA0KBE8TFifOEXddF9d_wqDjb4QUvgK8c0DTtyLrX0atA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/10/2023 11:58, Vincent Guittot wrote:
> On Mon, 23 Oct 2023 at 22:58, Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>>
>> Hi,
>>
>> On Wednesday 18 Oct 2023 at 18:25:40 (+0200), Vincent Guittot wrote:
>>> Use the new capacity_ref_freq to set the ratio that is used by AMU for
>>> computing the arch_scale_freq_capacity().
>>> This helps to keep everything aligned using the same reference for
>>> computing CPUs capacity.
>>>
>>> The default value of the ratio ensures that arch_scale_freq_capacity()
>>> returns max capacity until it is set to its correct value with the
>>> cpu capacity and capacity_ref_freq.

Nitpick: Could you mention that arch_max_freq_scale is the default value
for this ratio? Took me a while to recreate the (not so simple) story
for this change, i.e. make the connection between ratio and
arch_max_freq_scale.

init_cpu_capacity_callback()

  freq_inv_set_max_ratio()

    u64 ratio
    ...
    per_cpu(arch_max_freq_scale, cpu) = (unsigned long)ratio
            ^^^^^^^^^^^^^^^^^^^


static struct scale_freq_data amu_sfd = {
        .set_freq_scale = amu_scale_freq_tick,
}

#define arch_scale_freq_tick topology_scale_freq_tick

topology_scale_freq_tick()

  sfd->set_freq_scale()


amu_scale_freq_tick()

  ...
  scale *= this_cpu_read(arch_max_freq_scale)
                         ^^^^^^^^^^^^^^^^^^^
  ...
  this_cpu_write(arch_freq_scale, (unsigned long)scale);


#define arch_scale_freq_capacity topology_get_freq_scale

topology_get_freq_scale(cpu)

  return per_cpu(arch_freq_scale, cpu)

[...]


