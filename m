Return-Path: <linux-acpi+bounces-14603-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8ECAE8819
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 17:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21411C2626B
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 15:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59A82DAFA2;
	Wed, 25 Jun 2025 15:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bHCFcvY1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253612D9EF3
	for <linux-acpi@vger.kernel.org>; Wed, 25 Jun 2025 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750865005; cv=none; b=A1Pol8NiIwSJkh8c9ePiAf/tG00pGfaNFsSlw5mw4gS/KwzpTeswLx2ZwswDYy5UhgbHmFXpPdNlHKeyCKFL/5Hqg8rXHDUq9qmL1dUivo+mZ/mHlUslmSqxVJyR7XK2HOtqipKgEkvZ/qwGqzZ85DxYhBt4eXLLP2MPt4moFyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750865005; c=relaxed/simple;
	bh=OJhahzTU5jikkDGhekhNOXwMuEYXTI6H2+xeIg+QO8c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ibXPb8JmePwF8zHuep3M+6TnNJ0joHvNDqB70J4a6yLwMuGIBQd/tsq2LN+BEbvRowjGIOoO83OGuIdvc9aAb+Go1TlIUQ9DxJw5lamKmMCmh+2xHhygclex0slQN1yq/4Khw4/79XDGFUhaHShZiY51zNHaydlmXOZahlD2Crc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bHCFcvY1; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-408d14c7ebeso20802b6e.1
        for <linux-acpi@vger.kernel.org>; Wed, 25 Jun 2025 08:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750865003; x=1751469803; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=25cb6ywofofju5yiyffKokfXF+DzpevYPbvcdUpPAKI=;
        b=bHCFcvY1K5fygACbj0Fg2GnOaKBL/sd5Ur8YVUoUpBnUiB8ZjIazrSm3l0Gxyiz6nc
         rWmBlcgwaoa81qkIQtXbradkmtHmL6upmcKQkBm9/yoDpX054vQz/u/7p0jGMtgNfG9M
         f3bBu/pFYIL7xePlG+vxVVINI7bSxinvT2cvMFH6KGHqVs+pbo2kUNVoP20Nqd6ulu6c
         yUHaTv4E9yBsmdMcRZZiQ47vkiBuSiPt2rqrPJmfIDDCfXpB/alMhjQM7n2+sR0gx9zf
         srBv07csb873Nicztiz0vtV/VS4hPrGHMCGnAkd9b4ulYUzpRbh3Gf2xInjficw/5TOt
         qh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750865003; x=1751469803;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=25cb6ywofofju5yiyffKokfXF+DzpevYPbvcdUpPAKI=;
        b=Orezfyw0KwHxw27VHtRDrHraRTvLwzcNqW5R2UDDKtSk8gBAvJwYco16sYle91xrjw
         NDB6U4205Ss0BbSx1JDakctn8NncXi3lHLNJ3KXkuGt0RP1meVn+Vzuu7QBCiE9VADZg
         C9hpxot9iqdsUo9/mVsLWILWiFa9EMDd42jozHNca8ld3gxokyNpHJordZ5WGCuvCgwp
         Ver4oL/ENE9LnYPsdzSN3zuXBnwZCYNYUlBxBZvi82M36rs7znaXUkmZmn1/31ybVaoZ
         j0vzs1AMf/Kmgv6RQO8Vqigmtbh/UusHR0hs/oONaoeen5QeOpSgUa2Ag4+Zh9H6/VSu
         V6uw==
X-Forwarded-Encrypted: i=1; AJvYcCVG0K5F715NVcYTZxvlsMbt6Mghv8t5qX+LGDHArGlxcDCpIciQ/3sYmuRgSRQjGGUrGaEsf66cZUEU@vger.kernel.org
X-Gm-Message-State: AOJu0YznSXU1o/0jT/mOBBhO07Oimng4vIgLPNbi1I72rdlJe6IkkABL
	dD5xCOBYIf90VyQnYFUQRZkohBl6imsrHhEW5VGubOqF5SOmr8L8oiIg1KsPobZeMT0=
X-Gm-Gg: ASbGncsAOYBTSKebKcaH7ou/qFGs/fBtrkT+XL4O9hwUpAOgd8AO2AAY9FF/5i4iVQp
	Ilcgj8xHr+qqfEgBxFGoiih1bfasUMxs6lTxii0c7txObdw+VJSyKz9W6v5+h4+A75JvGh4dT6D
	IqA21iY+1aIL96C/95WgURuRoVasqz9LRzB2UtKj0ffRsMcEC1MompKqGuC6YmxEcQ+uufM1fmd
	Rwn/Emmb1PmFXGFG7HRkf2j/DXGUYKh9WEHP/IDGMq+VCEbkBzbJFgmsGJxc+nva40RxWhxhpyL
	yNLGqQ1GP1McdipA70rlKfBAleFG3atQNMOAvjLy30KZaqzk0GMu7mJ4btObaazbhNUu4A==
X-Google-Smtp-Source: AGHT+IEMyLiZGUQypsKou1S0v7NvpJac0zgfsgOVVppbI9pP+1Az7mMIxW50a2AuMIqt+r8e4q43sw==
X-Received: by 2002:a05:6808:1404:b0:409:f8e:7284 with SMTP id 5614622812f47-40b05728d39mr2786915b6e.6.1750865003174;
        Wed, 25 Jun 2025 08:23:23 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:1fca:a60b:12ab:43a3])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-40ac6d3f540sm2203127b6e.50.2025.06.25.08.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 08:23:22 -0700 (PDT)
Date: Wed, 25 Jun 2025 10:23:21 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org
Subject: [bug report] ACPI: APEI: EINJ: Discover EINJv2 parameters
Message-ID: <24d9ea9e-9837-4f60-92e9-9fc2ab1026ca@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Zaid Alali,

Commit 691a0f0a557b ("ACPI: APEI: EINJ: Discover EINJv2 parameters")
from Jun 17, 2025 (linux-next), leads to the following Smatch static
checker warning:

	drivers/acpi/apei/einj-core.c:331 einj_get_parameter_address()
	warn: using integer overflow function 'size_add()' for math

drivers/acpi/apei/einj-core.c
    286 static void __iomem *einj_get_parameter_address(void)
    287 {
    288         int i;
    289         u64 pa_v4 = 0, pa_v5 = 0;
    290         struct acpi_whea_header *entry;
    291 
    292         entry = EINJ_TAB_ENTRY(einj_tab);
    293         for (i = 0; i < einj_tab->entries; i++) {
    294                 if (entry->action == ACPI_EINJ_SET_ERROR_TYPE &&
    295                     entry->instruction == ACPI_EINJ_WRITE_REGISTER &&
    296                     entry->register_region.space_id ==
    297                     ACPI_ADR_SPACE_SYSTEM_MEMORY)
    298                         pa_v4 = get_unaligned(&entry->register_region.address);
    299                 if (entry->action == ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS &&
    300                     entry->instruction == ACPI_EINJ_WRITE_REGISTER &&
    301                     entry->register_region.space_id ==
    302                     ACPI_ADR_SPACE_SYSTEM_MEMORY)
    303                         pa_v5 = get_unaligned(&entry->register_region.address);
    304                 entry++;
    305         }
    306         if (pa_v5) {
    307                 struct set_error_type_with_address v5param;
    308                 struct set_error_type_with_address __iomem *p;
    309 
    310                 v5param_size = sizeof(v5param);
    311                 p = acpi_os_map_iomem(pa_v5, sizeof(*p));
    312                 if (p) {
    313                         int offset, len;
    314 
    315                         memcpy_fromio(&v5param, p, v5param_size);
    316                         acpi5 = 1;
    317                         check_vendor_extension(pa_v5, &v5param);
    318                         if (available_error_type & ACPI65_EINJV2_SUPP) {
    319                                 len = v5param.einjv2_struct.length;

My guess is that in real life all these values have to be correct.

    320                                 offset = offsetof(struct einjv2_extension_struct, component_arr);
    321                                 max_nr_components = (len - offset) /

Like you couldn't pass a negative len and expect this to boot etc...

    322                                                 sizeof(v5param.einjv2_struct.component_arr[0]);
    323                                 /*
    324                                  * The first call to acpi_os_map_iomem above does not include the
    325                                  * component array, instead it is used to read and calculate maximum
    326                                  * number of components supported by the system. Below, the mapping
    327                                  * is expanded to include the component array.
    328                                  */
    329                                 acpi_os_unmap_iomem(p, v5param_size);
    330                                 offset = offsetof(struct set_error_type_with_address, einjv2_struct);
--> 331                                 v5param_size = offset + struct_size(&v5param.einjv2_struct,

So the struct_size() here is probably just used for readability and not
for kernel hardening.  So the "offset + " is probably fine and doesn't
need to be changed to size_add(offset, struct_size());

    332                                         component_arr, max_nr_components);
    333                                 p = acpi_os_map_iomem(pa_v5, v5param_size);
    334                         }
    335                         return p;
    336                 }
    337         }
    338         if (param_extension && pa_v4) {
    339                 struct einj_parameter v4param;
    340                 struct einj_parameter __iomem *p;
    341 
    342                 p = acpi_os_map_iomem(pa_v4, sizeof(*p));
    343                 if (!p)
    344                         return NULL;
    345                 memcpy_fromio(&v4param, p, sizeof(v4param));
    346                 if (v4param.reserved1 || v4param.reserved2) {
    347                         acpi_os_unmap_iomem(p, sizeof(v4param));
    348                         return NULL;
    349                 }
    350                 return p;
    351         }
    352 
    353         return NULL;
    354 }

regards,
dan carpenter

