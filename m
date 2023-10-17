Return-Path: <linux-acpi+bounces-701-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886CF7CCE2F
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Oct 2023 22:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9DDF1C20A44
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Oct 2023 20:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E392E3F6
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Oct 2023 20:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FyAGsIsc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAE7EBE
	for <linux-acpi@vger.kernel.org>; Tue, 17 Oct 2023 18:38:43 +0000 (UTC)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B9C94
	for <linux-acpi@vger.kernel.org>; Tue, 17 Oct 2023 11:38:42 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-77432add7caso350694885a.2
        for <linux-acpi@vger.kernel.org>; Tue, 17 Oct 2023 11:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1697567921; x=1698172721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YsaRBkXVnZ5gQ0bfD3LH2OWV/lnyvaLOJpA+t9fKpcs=;
        b=FyAGsIscSHJwVwbXBvGZ7IaysOwZJMwMRzHrOhMsbvq+tFHQvTi5zaWdoNxZjvb3br
         eXKTmSA/5VcdOuFb9HvaGl1GFauaoIXl6K6R1ut9Gh2Y3mrG8sQfoKlObRCmiUdJlMuh
         gtGx0BvtL+3YEY+Mwii2RFrAezANHQa2Y60Y5mLLB73q1H8veXugQ1T5wIsLyFi2UPAk
         5T+pKtsCVF0Tryr7R+p8ZYs1PfjE6P5LTBCsmYrOK06cSxTqUm3mkQ6TBoy+wfvaX6HC
         fOt1I+lNqzgUIz/12rtJ6MYLQJKr8F2dTRkiec67+5zXDdPtySuEWOakx5Cb4TbELkhP
         nfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697567921; x=1698172721;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YsaRBkXVnZ5gQ0bfD3LH2OWV/lnyvaLOJpA+t9fKpcs=;
        b=iwa8W6CCPLdhsj+HBb7bo69kjCGjbNdnmOaLwWk68mWlHX23PfBUOr/13ZsmpevhZV
         lM3Jf6Xqraj1eO8AMHwV8bRpTvIC79T0h7bZdrFfbV2ipY9OLDkIVb4jQA2ScPFJlowu
         n/5cUmhkVEwqcf2JWSoLxRZ287mE5HYbyyaJwD11rf6PNGzL51gMVHyhKSPXCc3Mi2CG
         y0eMjWxILfP5TtKaxgwixkf8oSqBafkWlkoWZ4XUrVKbOgPkJhobC1152CtvXwApTMry
         5wTXRD0YMyhmGtrmRckgH5lNoh1wrK4vD06dfhR5qucVtTZQVIMeKF6SrTtDVjngHDi3
         vCQw==
X-Gm-Message-State: AOJu0YyHMQOsSGo6Dfgrt0PfgQLgtGkZS1bF6HBVrbA9IubydodbACR0
	vDcEJfzUSOogBCWFRUBKamjuzw==
X-Google-Smtp-Source: AGHT+IEb4loGMCpPOVn6Ab+wN9cQ9sYm3udk2P0fPAOn+o3REaidWVnlpV97HdQcRaGqmi3sZ0ab3A==
X-Received: by 2002:a05:620a:3951:b0:773:c075:a4e7 with SMTP id qs17-20020a05620a395100b00773c075a4e7mr3115161qkn.11.1697567921072;
        Tue, 17 Oct 2023 11:38:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:2000:b002:95cc:ccc5:95bc:7d2c? ([2600:1700:2000:b002:95cc:ccc5:95bc:7d2c])
        by smtp.gmail.com with ESMTPSA id f9-20020a05620a408900b007677347e20asm866377qko.129.2023.10.17.11.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 11:38:40 -0700 (PDT)
Message-ID: <a65fd79f-e0d3-4618-9579-d4a19ba91302@sifive.com>
Date: Tue, 17 Oct 2023 13:38:39 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 -next 3/3] RISC-V: cacheflush: Initialize CBO variables
 on ACPI systems
Content-Language: en-US
To: Sunil V L <sunilvl@ventanamicro.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Anup Patel <apatel@ventanamicro.com>, Albert Ou <aou@eecs.berkeley.edu>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Atish Kumar Patra <atishp@rivosinc.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Andrew Jones <ajones@ventanamicro.com>,
 Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>
References: <20231016164958.1191529-1-sunilvl@ventanamicro.com>
 <20231016164958.1191529-4-sunilvl@ventanamicro.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20231016164958.1191529-4-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-10-16 11:49 AM, Sunil V L wrote:
> Initialize the CBO variables on ACPI based systems using information in
> RHCT.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/riscv/mm/cacheflush.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>


