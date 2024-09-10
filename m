Return-Path: <linux-acpi+bounces-8216-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D0D97377D
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2024 14:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34D371F26630
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2024 12:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB56F1917F0;
	Tue, 10 Sep 2024 12:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LO1Xbjex"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C3F191496
	for <linux-acpi@vger.kernel.org>; Tue, 10 Sep 2024 12:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725971702; cv=none; b=dXgikPVkoXahOhuPEdkG8cteRt8yvDP7LCjTn453KSz/YHTb2CpB2/7/ke/7BLGLQRgbQUq6NW6hnJU28osS3Qxc7xgVU5pJznfPFkicfpZiW2aZPWzjjnt0XvQawOYsxfTkxnqDADM9eyyogcVNPBS1OCX/1SOLWv/OknXeMHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725971702; c=relaxed/simple;
	bh=YPxL+WStp4d5x5HW+heH1w6KnMYpLQkMgr/GiunWpXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jIM/zuq5ykLbbDLx7ydFjXK8FekSMjoI7+feNeyrjzukNex1uSjz+1AqqQxueX0Bf/q73u7BjiCrFTJoQNXILHWcU/n8/2DDl+MEOBHc7xxDmbhh0yha0lJTXHa97KPiu3+WPe8h+WYGgF6iNLOAJNb6Go7Qr1QECFucTTC/YD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LO1Xbjex; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c241feb80dso12447974a12.0
        for <linux-acpi@vger.kernel.org>; Tue, 10 Sep 2024 05:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725971699; x=1726576499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LSsewx7UU6gQEwik2bNEi5/xY6888BEnxTjH/v5O+cc=;
        b=LO1Xbjex5/aGLzTGQvlhGgCLVNO2MeUnpUOzuwdUc868j4YCrHgUZACCkQ7TflJQhc
         SCC6Uneus0AgTOZmLKwhsEozoME6yERzSLbUesszHvMy7o1wnU8pYIvUkznAm6szliGb
         O/KIyvRecjzI9hzusK1EpieoevkEkB1a4l+8SZ/HMisxOTpXfR5SU+YF2mNhkYQGv8+6
         kkFHq70UlO6DrSIqoHgdTZk/nbsNlGo2bITXMzZegUnAq4Y1ZY6LcIM8hZG/P83Ase/m
         Mpc0x/IiWYs/7BKZAP44mN0A8LibA1Pe/jvMQTrQg0TQrpV+5isdWNvIcVbmd82ejLUx
         GdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725971699; x=1726576499;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSsewx7UU6gQEwik2bNEi5/xY6888BEnxTjH/v5O+cc=;
        b=KzCBmeX/uXRY1ZmOrxsoyU7qSEELEFhAw6vV0D7i8+zjevTi8d7NfW/5WmZrEtBsVf
         1uSGwFi0cF7Di0TAR/G/A8TkUZZyqS9AdERkJZQw5qcJVq9IfM2QZijQaf61QXb1SgF/
         aZIYIN8Z4bk613479p4FzRa5PlulWmkkKtVh/xURue/qebf4uqhTNPi8jk3uu1ByYxdI
         O7c6Q6X1SRkBRX1Ete+WSlXJM7pLUJ0ZcIMaKmxyzzHvmxLhZlvFcteGz1cqzFrJJ1BD
         sHd319qeRs1UzjqGXJrwkPH8ju7RyoNtbPns3UhuXmTeodhtQc85bLEvY2y0j832JRhJ
         nILg==
X-Forwarded-Encrypted: i=1; AJvYcCXO0AIgKKjqyZ9AvDVmlkpRuok3jVZZy2wV/CzL/W/qa/1wP9rMkGVkX+IQDzdZG/MDk9ddzxaPQc86@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfmqr5+qvgMsXLZyQplL54wz8ywGEkMCya3AcFCK9LeIYO9WG0
	6KmzGbVx88IY7AeCSDL8atkhkGkmZf/7hBizHimJmZNMYATfQhEMni3OtjZP2w==
X-Google-Smtp-Source: AGHT+IHELrHmlAkPKV+ybsGZZAWa6S6u/zQgSyh6j6a/3oTZxhoBs4+pUZuEmgEWmeYEHs9VSlDY4A==
X-Received: by 2002:a17:907:972a:b0:a72:7a71:7f4f with SMTP id a640c23a62f3a-a8ffb1b644emr55038566b.7.1725971698680;
        Tue, 10 Sep 2024 05:34:58 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c61263sm478368866b.128.2024.09.10.05.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 05:34:58 -0700 (PDT)
Message-ID: <6bed58f8-016f-4390-be4c-128eebff6545@suse.com>
Date: Tue, 10 Sep 2024 14:34:58 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] xen: allow mapping ACPI data using a different
 physical address
To: Juergen Gross <jgross@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-acpi@vger.kernel.org
References: <20240910103932.7634-1-jgross@suse.com>
 <20240910103932.7634-7-jgross@suse.com>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <20240910103932.7634-7-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10.09.2024 12:39, Juergen Gross wrote:
> When running as a Xen PV dom0 the system needs to map ACPI data of the
> host using host physical addresses, while those addresses can conflict
> with the guest physical addresses of the loaded linux kernel. The same
> problem might apply in case a PV guest is configured to use the host
> memory map.
> 
> This conflict can be solved by mapping the ACPI data to a different
> guest physical address, but mapping the data via acpi_os_ioremap()
> must still be possible using the host physical address, as this
> address might be generated by AML when referencing some of the ACPI
> data.
> 
> When configured to support running as a Xen PV domain, have an
> implementation of acpi_os_ioremap() being aware of the possibility to
> need above mentioned translation of a host physical address to the
> guest physical address.
> 
> This modification requires to fix some #include of asm/acpi.h in x86
> code to use linux/acpi.h instead.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Jan Beulich <jbeulich@suse.com>
with a request to comment a tiny bit more:

> @@ -836,6 +837,33 @@ void __init xen_do_remap_nonram(void)
>  	pr_info("Remapped %u non-RAM page(s)\n", remapped);
>  }
>  
> +#ifdef CONFIG_ACPI
> +/*
> + * Xen variant of acpi_os_ioremap() taking potentially remapped non-RAM
> + * regions into acount.

(Nit: account)

> + * Any attempt to map an area crossing a remap boundary will produce a
> + * WARN() splat.
> + */
> +static void __iomem *xen_acpi_os_ioremap(acpi_physical_address phys,
> +					 acpi_size size)
> +{
> +	unsigned int i;
> +	const struct nonram_remap *remap = xen_nonram_remap;
> +
> +	for (i = 0; i < nr_nonram_remap; i++) {
> +		if (phys + size > remap->maddr &&
> +		    phys < remap->maddr + remap->size) {
> +			WARN_ON(phys < remap->maddr ||
> +				phys + size > remap->maddr + remap->size);
> +			phys = remap->paddr + phys - remap->maddr;

This might be slightly easier / more logical to read as

			phys += remap->paddr - remap->maddr;

Also because of "phys" not consistently expressing a physical address
(when you need convert it, the incoming value is a machine address) a
comment may help here. In fact at the first glance (and despite having
seen the code before) I thought the translation was done the wrong way
round, simply because of the name of the variable.

Jan

