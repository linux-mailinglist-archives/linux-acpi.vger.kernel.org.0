Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE31651BD
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Jul 2019 08:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfGKGMN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 11 Jul 2019 02:12:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38749 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbfGKGMN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Jul 2019 02:12:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id z75so2393280pgz.5
        for <linux-acpi@vger.kernel.org>; Wed, 10 Jul 2019 23:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JjqHcbw1pBSBh/+FK6Hlik7p5Jx5rbYg1s03r+OqIc8=;
        b=WlnY5o6jeAXhGiTNM8EnDcCVY8zQ1H9zLtceVVstwXNhXlV5X0m23PfB+cpXNrgQ8R
         R7/c2qpu9RoNLhCKEfqPf4/kB9UmbGt51t+y2Foo4N0HeRYc3kpRjPADueRI9nmiGuZk
         ToZYAf/7ovTvU3z6a5V3p/lcID19SFTpcHOeEN5H4ooYTOlxcj4xdKOrzR7BVdbE8IcM
         7mHeO2ynBmvJtQws51pv6DmxTR0xseAyoP6BmctBSlsKAkoNZ+FamDWNq3ST2c8nXijH
         aSpz6v507yUKkHI4/c1w2IF8aG1F4r/uls076FEDfd0BmSkvZP11fN3vIsXTR9LFvUUJ
         du4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JjqHcbw1pBSBh/+FK6Hlik7p5Jx5rbYg1s03r+OqIc8=;
        b=kvowB/r4Tl+hfjnhI/cn9LQeegygCGWouHIUvxsYjDkCfIvcqhLoJkkqD+erx9Dplv
         qyanpkTV7xPyMp0cbO3HAXix9TKrjTpg/YNLaUaE+v7dtSofhnWzU4J2tUqMfjcM5wpr
         tByKJdQNjERqrnd3fy4WSFEk0QCEOWuyWgWNbMNP6FQY9JisMA5stETtIpFPmmBlq/Oe
         s4iCyCk3fIg9N7IfgAmrwx4AqQOi0rLVMhNudFP0eIVeBXR3YYOed4R4ifeEQ9bt60s6
         H4ZWCP+MsNaBqhdDrVP+6XAFh9SKNth0MCIO5k7h2tsqG0wG1UT0J3d8kTIcZa3gHdyp
         TGxA==
X-Gm-Message-State: APjAAAVU37hvJHyjjHsfX3Sd3/KVl7K5BS8pvebjKRFraVxQETX9uq/v
        d6Eg/SmbDi3xi+EY11LnrdwQFQ==
X-Google-Smtp-Source: APXvYqz+IRV9S4TRQfHzUTKweyyIYhjBuXJS09c+P73+ly5nwrMQwJz65cCIaPtXDlwqg4j/e9ltdg==
X-Received: by 2002:a17:90a:2244:: with SMTP id c62mr2872730pje.29.1562825531957;
        Wed, 10 Jul 2019 23:12:11 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id m9sm6449631pgr.24.2019.07.10.23.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 23:12:10 -0700 (PDT)
Date:   Thu, 11 Jul 2019 11:42:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Subject: Re: [PATCHv3 6/6] drivers/cpufreq: Add a CPUFreq driver for AMD
 processors (Fam17h and later)
Message-ID: <20190711061208.yqxt4ps67vmsy7sp@vireshk-i7>
References: <cover.1562781484.git.Janakarajan.Natarajan@amd.com>
 <e48c6b836f996a16472c777612f1e3343c542077.1562781484.git.Janakarajan.Natarajan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e48c6b836f996a16472c777612f1e3343c542077.1562781484.git.Janakarajan.Natarajan@amd.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 10-07-19, 18:37, Natarajan, Janakarajan wrote:
> diff --git a/drivers/cpufreq/amd-cpufreq.c b/drivers/cpufreq/amd-cpufreq.c
> +#define pr_fmt(fmt)	"AMD Cpufreq: " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/cpu.h>
> +#include <linux/vmalloc.h>
> +#include <linux/cpufreq.h>
> +#include <linux/acpi.h>
> +#include <linux/delay.h>

Please keep them in alphabetical order.

> +
> +#include <asm/unaligned.h>
> +
> +#include <acpi/cppc_acpi.h>
> +
> +struct amd_desc {
> +	int cpu_id;
> +	struct cppc_ctrls ctrls;
> +	struct kobject kobj;
> +};
> +
> +struct amd_desc **all_cpu_data;
> +
> +static unsigned int cppc_enable;
> +module_param(cppc_enable, uint, 0644);
> +MODULE_PARM_DESC(cppc_enable,
> +		 "1 - enable AMD CpuFreq, create CPPC sysfs entries.");
> +
> +#define to_amd_desc(a) container_of(a, struct amd_desc, kobj)
> +
> +#define show_func(access_fn, struct_name, member_name)			\
> +	static ssize_t show_##member_name(struct kobject *kobj,		\
> +					  struct kobj_attribute *attr,	\
> +					  char *buf)			\
> +	{								\
> +		struct amd_desc *desc = to_amd_desc(kobj);		\
> +		struct struct_name st_name = {0};			\
> +		int ret;						\
> +									\
> +		ret = access_fn(desc->cpu_id, &st_name);		\
> +		if (ret)						\
> +			return ret;					\
> +									\
> +		return scnprintf(buf, PAGE_SIZE, "%llu\n",		\
> +				 (u64)st_name.member_name);		\
> +	}								\
> +
> +#define store_func(struct_name, member_name, reg_idx)			\
> +	static ssize_t store_##member_name(struct kobject *kobj,	\
> +					   struct kobj_attribute *attr,	\
> +					   const char *buf, size_t count)\
> +	{								\
> +		struct amd_desc *desc = to_amd_desc(kobj);		\
> +		struct struct_name st_name = {0};			\
> +		u32 val;						\
> +		int ret;						\
> +									\
> +		ret = kstrtou32(buf, 0, &val);				\
> +		if (ret)						\
> +			return ret;					\
> +									\
> +		st_name.member_name = val;				\
> +									\
> +		ret = cppc_set_reg(desc->cpu_id, &st_name, reg_idx);	\
> +		if (ret)						\
> +			return ret;					\
> +									\
> +		return count;						\
> +	}								\
> +
> +#define define_one_rw(struct_name, access_fn, member_name, reg_idx)	\
> +	show_func(access_fn, struct_name, member_name)			\
> +	store_func(struct_name, member_name, reg_idx)			\
> +	define_one_global_rw(member_name)
> +
> +define_one_rw(cppc_ctrls, cppc_get_ctrls, enable, ENABLE);
> +define_one_rw(cppc_ctrls, cppc_get_ctrls, max_perf, MAX_PERF);
> +define_one_rw(cppc_ctrls, cppc_get_ctrls, min_perf, MIN_PERF);
> +define_one_rw(cppc_ctrls, cppc_get_ctrls, desired_perf, DESIRED_PERF);
> +define_one_rw(cppc_ctrls, cppc_get_ctrls, auto_sel_enable, AUTO_SEL_ENABLE);
> +
> +static struct attribute *amd_cpufreq_attributes[] = {
> +	&enable.attr,
> +	&max_perf.attr,
> +	&min_perf.attr,
> +	&desired_perf.attr,
> +	&auto_sel_enable.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group amd_cpufreq_attr_group = {
> +	.attrs = amd_cpufreq_attributes,
> +};
> +
> +static struct kobj_type amd_cpufreq_type = {
> +	.sysfs_ops = &kobj_sysfs_ops,
> +	.default_attrs = amd_cpufreq_attributes,
> +};
> +
> +static int amd_cpufreq_cpu_init(struct cpufreq_policy *policy)
> +{
> +	return 0;
> +}
> +
> +static int amd_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> +{
> +	return 0;
> +}
> +
> +static int amd_cpufreq_cpu_verify(struct cpufreq_policy *policy)
> +{
> +	return 0;
> +}
> +
> +static int amd_cpufreq_cpu_target_index(struct cpufreq_policy *policy,
> +					unsigned int index)
> +{
> +	return 0;
> +}

All empty helpers ? There is nothing you need to do ?

> +
> +static struct cpufreq_driver amd_cpufreq_driver = {
> +	.name = "amd_cpufreq",
> +	.init = amd_cpufreq_cpu_init,
> +	.exit = amd_cpufreq_cpu_exit,
> +	.verify = amd_cpufreq_cpu_verify,
> +	.target_index = amd_cpufreq_cpu_target_index,
> +};
> +
> +static void amd_cpufreq_sysfs_delete_params(void)
> +{
> +	int i;
> +
> +	for_each_possible_cpu(i) {
> +		if (all_cpu_data[i]) {
> +			kobject_del(&all_cpu_data[i]->kobj);

Shouldn't you use kobject_put() instead of this ?

> +			kfree(all_cpu_data[i]);
> +		}
> +	}
> +
> +	kfree(all_cpu_data);
> +}
> +
> +static int __init amd_cpufreq_sysfs_expose_params(void)
> +{
> +	struct device *cpu_dev;
> +	int i, ret;
> +
> +	all_cpu_data = kcalloc(num_possible_cpus(), sizeof(void *),
> +			       GFP_KERNEL);
> +
> +	if (!all_cpu_data)
> +		return -ENOMEM;
> +
> +	for_each_possible_cpu(i) {
> +		all_cpu_data[i] = kzalloc(sizeof(struct amd_desc), GFP_KERNEL);
> +		if (!all_cpu_data[i]) {
> +			ret = -ENOMEM;
> +			goto free;
> +		}
> +
> +		all_cpu_data[i]->cpu_id = i;
> +		cpu_dev = get_cpu_device(i);
> +		ret = kobject_init_and_add(&all_cpu_data[i]->kobj, &amd_cpufreq_type,
> +					   &cpu_dev->kobj, "amd_cpufreq");
> +		if (ret)
> +			goto free;
> +	}
> +
> +	return 0;
> +free:
> +	amd_cpufreq_sysfs_delete_params();
> +	return ret;
> +}

Instead of doing this once for all CPUs, it would be better to do it
every time the ->init() callback of the driver gets called. If you
have one cpufreq policy for each CPU (i.e. no CPUs share clock lines),
then the init() callback will get called once for each CPU.

> +
> +static int __init amd_cpufreq_init(void)
> +{
> +	int ret = 0;
> +
> +	/*
> +	 * Use only if:
> +	 * - AMD,
> +	 * - Family 17h (or) newer and,
> +	 * - Explicitly enabled
> +	 */
> +	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD ||
> +	    boot_cpu_data.x86 < 0x17 || !cppc_enable)
> +		return -ENODEV;
> +
> +	ret = cpufreq_register_driver(&amd_cpufreq_driver);
> +	if (ret) {
> +		pr_info("Failed to register driver\n");
> +		goto out;
> +	}
> +
> +	ret = amd_cpufreq_sysfs_expose_params();
> +	if (ret) {
> +		pr_info("Could not create sysfs entries\n");
> +		cpufreq_unregister_driver(&amd_cpufreq_driver);
> +		goto out;
> +	}
> +
> +	pr_info("Using amd-cpufreq driver\n");
> +	return ret;
> +
> +out:
> +	return ret;
> +}
> +
> +static void __exit amd_cpufreq_exit(void)
> +{
> +	amd_cpufreq_sysfs_delete_params();
> +	cpufreq_unregister_driver(&amd_cpufreq_driver);
> +}
> +
> +static const struct acpi_device_id amd_acpi_ids[] __used = {
> +	{ACPI_PROCESSOR_DEVICE_HID, },
> +	{}
> +};
> +
> +device_initcall(amd_cpufreq_init);
> +module_exit(amd_cpufreq_exit);
> +MODULE_DEVICE_TABLE(acpi, amd_acpi_ids);

All three should be placed directly below the struct/function they
represent without any blank lines in between. As suggested in
kernel documentation.

> +
> +MODULE_AUTHOR("Janakarajan Natarajan");
> +MODULE_DESCRIPTION("AMD CPUFreq driver based on ACPI CPPC v6.1 spec");
> +MODULE_LICENSE("GPL");

Should this be "GPL v2" ?

> -- 
> 2.17.1

-- 
viresh
