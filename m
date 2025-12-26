Return-Path: <linux-acpi+bounces-19865-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6796BCDEB7F
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Dec 2025 14:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52DB53004787
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Dec 2025 13:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B3731ED95;
	Fri, 26 Dec 2025 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a6cm/P+v"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC0029B8EF
	for <linux-acpi@vger.kernel.org>; Fri, 26 Dec 2025 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766754775; cv=none; b=Lrhd5zkOtuipfiNM2ikaUXFwIV+T4Ngd28+6rMhH6tgJZ09Ow7lRH5yar5pnl3PpxQ9rTJJiXR/+mppioxr/AaUhR+VN/8LTjXgN12zrRnQlLVgg6vdQ2YxP7ECjxtQAWRuBHGimOu5MO4sZqnG4YfCqBFGp/MHCJ6xnJk1wgcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766754775; c=relaxed/simple;
	bh=Zzyrkv+jDg1lPu6LLx7PPcO2dvReUtPC3A4PLs347n8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KA8aSnoLS0x+KXXTDtz4erDQrDDWCgl4q/LsTv2hrHKeQjrDZP0iXTjPnPmhHTRz/A6I2za0GjafSnmvZ/UMZW5DJNNRJuUclIDfqcFMsnRHWPx9vkcG+fjoJ364G3p2q6t5D/vuozRgNX72m7PsrdzAV1yWrV0OYv/g1g5o92M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a6cm/P+v; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4775ae77516so68538235e9.1
        for <linux-acpi@vger.kernel.org>; Fri, 26 Dec 2025 05:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766754771; x=1767359571; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q7jnzss7SrgncsYKHhnBFIr8PlxYdzd1neAXYIb5ojw=;
        b=a6cm/P+vWSS8grV/VcwzUCRlaIXsYCZNmR4ZND1Oq8FoxAhTSEsIbAWuL+My1nzd+2
         OTjeiIFJPUXc4b4KiSB4slx0DUY6hUfFN36qy8je/fwV4FuKrXwIz2AzC/pEzv3irODV
         SbDV6YWxRhKOp+HYxusE5iNXXY965MraCN+MqiKxASiB3poLdc2gB7oWConMJPgXczdv
         g4iaLF9ksbv7YfLHvoQY8FKjKLAkCW4f1cOsrhFJC6Jz5+078yj5KU9ombZXnl9k1COo
         eOwr5UF+7+Lg542bcsCBuZX7SZiRUG/vaz3fZxMcTVNUHAIrDQNoE1kREpe8eFDXLXy/
         vSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766754771; x=1767359571;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7jnzss7SrgncsYKHhnBFIr8PlxYdzd1neAXYIb5ojw=;
        b=jKB7me7J/LxZDCi3QGbP8NkszZV3Xy74ziRi7e1l/P7ym7VW8QRnc6YYWY/k2v82j5
         YO029O1iK24Ktj456Kyj+N61kbrbQyQ2qE319Ht0TvRzhx7YL8nKSP76SRL76BYk4hkv
         qqX8venpYaa1wcwsT/ovCdNxdqKrvW+TCnWUrIn+69kdkp928LVNLTpG/0xq/+7WSmNH
         Fp9hjpTST79ZwLRkM4Xcgz0/VA9KPB7diEoVbLOeSN5eM4TWD6wFKE97hX6iVvSjDXGg
         cr8RC8cJpaCt41TsUuzUPY1nlU9N7GkoArja8MLhw0ST4j6LxAoYF3KCapy7YjcocjLv
         dEJg==
X-Forwarded-Encrypted: i=1; AJvYcCUch/SmoDrvYs1O2P0PB/rQlpG/ckRv3nZ90NoSDyoNb2fJwFIVD4o9al0OGjcHJaB+Ug0OdjZZ6fA3@vger.kernel.org
X-Gm-Message-State: AOJu0YzOOz3PC+HKeMcv/ga+By4L8BISTJ/UopDhtJsfQJ4c/9H9Nb1h
	MyfXjyjLRTrizIaLkLD8xq7GFwyvn6QF7tuHidNlAZ4eAVl2G0DzKXYbHSlFXXqYvKw=
X-Gm-Gg: AY/fxX6dICQQR5Gn/D3PR7CydISYxofnUJTs18+BEg1mCQVCZnXSp9oS3wvCd7G2GSE
	iUeuqkmIKZcWuFKJDts13dhTpglklPdjzJJgGZIt1O8Nlx2RqDJ4h93c8svOowvQUWhil92u5qU
	fLtGYkZqaPXolTkrTqCCx+cb7UPOE3qChahaZoOlkOP819iobmu4fqJCcJsIB0T7fq8+dQjIap6
	phmxO3C30HNUQWcaDEMJVum6XsRZZbTFx4YAgu+/snibDgOn1BfbtPb8jRL/0Isqcz8E+P8uQMW
	MZa+REIab8X/gGDV1QqB8utJiM1/s9AenAL/2s1P1IPdQrg+zoVXKoTdIfTCtig2XlQ8hRPRfYG
	J/k1tQpObVJnQROpXSLZYVattmDFTZAdk3aKrfxCZvQImVKGIKXBhIdMIfnWbogZP0VdXWnie6p
	ggJGKQJJ/+zVVu2NmJ
X-Google-Smtp-Source: AGHT+IGKzcbgQ+tXH1pXY7Tmn2bUwHhALa3rlAg9XLT80pEqkBwfhsO4hiRp/bMzr/tOXSWghlfGDA==
X-Received: by 2002:a05:600c:3b1f:b0:477:9b4a:a82 with SMTP id 5b1f17b1804b1-47d36c75e0cmr122805055e9.35.1766754770832;
        Fri, 26 Dec 2025 05:12:50 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be279c5f8sm423216845e9.9.2025.12.26.05.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 05:12:50 -0800 (PST)
Date: Fri, 26 Dec 2025 16:12:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [rafael-pm:bleeding-edge 69/72] drivers/acpi/bus.c:339
 acpi_osc_handshake() warn: variable dereferenced before check 'cap' (see
 line 332)
Message-ID: <202512242052.W4GhDauV-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   e08ef982088f28cd65654693f29ffe430a9d4d66
commit: e5322888e6bf4ec17964a93638c9b14433a2f6f1 [69/72] ACPI: bus: Rework the handling of \_SB._OSC platform features
config: x86_64-randconfig-161-20251224 (https://download.01.org/0day-ci/archive/20251224/202512242052.W4GhDauV-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.4.0-5) 12.4.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202512242052.W4GhDauV-lkp@intel.com/

New smatch warnings:
drivers/acpi/bus.c:339 acpi_osc_handshake() warn: variable dereferenced before check 'cap' (see line 332)
drivers/acpi/bus.c:339 acpi_osc_handshake() warn: sizeof(NUMBER)?

Old smatch warnings:
drivers/acpi/bus.c:297 acpi_run_osc() warn: sizeof(NUMBER)?

vim +/cap +339 drivers/acpi/bus.c

e5322888e6bf4e Rafael J. Wysocki 2025-12-22  328  static int acpi_osc_handshake(acpi_handle handle, const char *uuid_str,
e5322888e6bf4e Rafael J. Wysocki 2025-12-22  329  			      int rev, struct acpi_buffer *cap)
e5322888e6bf4e Rafael J. Wysocki 2025-12-22  330  {
e5322888e6bf4e Rafael J. Wysocki 2025-12-22  331  	union acpi_object in_params[4], *out_obj;
e5322888e6bf4e Rafael J. Wysocki 2025-12-22 @332  	size_t bufsize = cap->length / sizeof(u32);
                                                                         ^^^^^^^^^^^
The cap pointer is dereferenced here.

e5322888e6bf4e Rafael J. Wysocki 2025-12-22  333  	struct acpi_object_list input;
e5322888e6bf4e Rafael J. Wysocki 2025-12-22  334  	struct acpi_buffer output;
e5322888e6bf4e Rafael J. Wysocki 2025-12-22  335  	u32 *capbuf, *retbuf, test;
e5322888e6bf4e Rafael J. Wysocki 2025-12-22  336  	guid_t guid;
e5322888e6bf4e Rafael J. Wysocki 2025-12-22  337  	int ret, i;
e5322888e6bf4e Rafael J. Wysocki 2025-12-22  338  
e5322888e6bf4e Rafael J. Wysocki 2025-12-22 @339  	if (!cap || cap->length < 2 * sizeof(32) || guid_parse(uuid_str, &guid))
                                                            ^^^^
Checked too late.
                                                                                      ^^^^^^^^^^
Also this sizeof(32) should be sizeof(u32) although both are the same
so the current code works.

e5322888e6bf4e Rafael J. Wysocki 2025-12-22  340  		return -EINVAL;
e5322888e6bf4e Rafael J. Wysocki 2025-12-22  341  
e5322888e6bf4e Rafael J. Wysocki 2025-12-22  342  	/* First evaluate _OSC with OSC_QUERY_ENABLE set. */
e5322888e6bf4e Rafael J. Wysocki 2025-12-22  343  	capbuf = cap->pointer;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


