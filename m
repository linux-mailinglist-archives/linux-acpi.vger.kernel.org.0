Return-Path: <linux-acpi+bounces-8729-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C912699B653
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Oct 2024 19:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAF961C20C3E
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Oct 2024 17:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99FA6F06A;
	Sat, 12 Oct 2024 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peKxWGrw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7564D22083;
	Sat, 12 Oct 2024 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728754449; cv=none; b=jEYam/njUQjBUuaLDPXcJwLuqWzW8unOsR4INEWftk6imqz2ChE0ETE34GyDv3RpYAMMycxJ82zpo7G1HO+Mw7sVVfciw06YuQ9kgqRWHqRoc6MKV/nTRkbS3tIt9ccUsy4BBjIfxSX9urrdrQBD4kNioCxuzW4EXVQuyuUDl20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728754449; c=relaxed/simple;
	bh=WxZIcq+iQPIXa3sSTYV2bGd68tYlonJCyY0WBpuj98k=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dFHX0GueqSPQBkPV8MAmkacEkB1Lt3oI97lrqoo9BVwVHyQ79bb4tl63wWeVe3smryyN2VJRgvhXkRC5D09hRYsFHmEL+mVVSlrZI7fult1FPnxyOhCn+CLdAj5Shv7S82oHvxo2g1vdXcYXpVQThrhIr+0zbD2aGUGbvKPxMHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peKxWGrw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD0DC4CEC6;
	Sat, 12 Oct 2024 17:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728754449;
	bh=WxZIcq+iQPIXa3sSTYV2bGd68tYlonJCyY0WBpuj98k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=peKxWGrwzr8FxSfY/QjwmIXCleiviobuhU6FBPH6JimLjIRSOKW8nsVz+QhJogUNl
	 NW3dr6z8Amgs2NA2o5ldu5ceftEkVPF9gK/ecQWuDjcptM/rPIuTaGMrbr0qMkyKu0
	 fA+oIn1vbGG8lC4HwII7COJkw0grH4C8pe37PZpLBoGx/jgqPCEbLq77yCO1iNDCUD
	 Wo/Ae+6RroBPYFERuRNReTYTk5QQTURrPjAM7QXBAZa4ePgtJljzkYAvk1Oht6MU/5
	 Vj/IC1g/DEaVri3Zxk2CAhr7rX9kaUtJAyDD6D9lGU0FYfF5YJjae/QAm21ZktYync
	 SqEmyp0aj0Gcg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=wait-a-minute.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1szg0E-002uES-98;
	Sat, 12 Oct 2024 18:34:06 +0100
Date: Sat, 12 Oct 2024 18:34:05 +0100
Message-ID: <8734l1usxe.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Zheng Zengkai <zhengzengkai@huawei.com>
Cc: <lpieralisi@kernel.org>,
	<guohanjun@huawei.com>,
	<sudeep.holla@arm.com>,
	<mark.rutland@arm.com>,
	<rafael@kernel.org>,
	<lenb@kernel.org>,
	<daniel.lezcano@linaro.org>,
	<tglx@linutronix.de>,
	<linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ACPI: GTDT: Tighten the check for the array of platform timer structures
In-Reply-To: <20241012085343.6594-1-zhengzengkai@huawei.com>
References: <20241012085343.6594-1-zhengzengkai@huawei.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.4
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: zhengzengkai@huawei.com, lpieralisi@kernel.org, guohanjun@huawei.com, sudeep.holla@arm.com, mark.rutland@arm.com, rafael@kernel.org, lenb@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Sat, 12 Oct 2024 09:53:43 +0100,
Zheng Zengkai <zhengzengkai@huawei.com> wrote:
> 
> As suggested by Marc and Lorenzo, first we need to check whether the
> platform_timer entry pointer is within gtdt bounds (< gtdt_end) before
> de-referencing what it points at to detect the length of the platform
> timer struct and then check that the length of current platform_timer
> struct is within gtdt_end too. Now next_platform_timer() only checks
> against gtdt_end for the entry of subsequent platform timer without
> checking the length of it and will not report error if the check failed.
> 
> Add check against table length (gtdt_end) for each element of platform
> timer array in acpi_gtdt_init() early, making sure that both their entry
> and length actually fit in the table.
> 
> For the first platform timer, keep the check against the end of the
> acpi_table_gtdt struct, it is unnecessary for subsequent platform timer.

Really?

>
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Suggested-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
> ---
> Changes in v2:
> - Check against gtdt_end for both entry and len of each array element
> 
> v1: https://lore.kernel.org/all/20241010144703.113728-1-zhengzengkai@huawei.com/
> ---
>  drivers/acpi/arm64/gtdt.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
> index c0e77c1c8e09..f5f62643899d 100644
> --- a/drivers/acpi/arm64/gtdt.c
> +++ b/drivers/acpi/arm64/gtdt.c
> @@ -157,6 +157,8 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
>  {
>  	void *platform_timer;
>  	struct acpi_table_gtdt *gtdt;
> +	struct acpi_gtdt_header *gh;
> +	void *struct_end;
>  
>  	gtdt = container_of(table, struct acpi_table_gtdt, header);
>  	acpi_gtdt_desc.gtdt = gtdt;
> @@ -177,11 +179,20 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
>  	}
>  
>  	platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
> -	if (platform_timer < (void *)table + sizeof(struct acpi_table_gtdt)) {
> -		pr_err(FW_BUG "invalid timer data.\n");
> -		return -EINVAL;
> +	struct_end = (void *)table + sizeof(struct acpi_table_gtdt);
> +	for (int i = 0; i < gtdt->platform_timer_count; i++) {
> +		gh = platform_timer;
> +		if (((i == 0 && platform_timer >= struct_end) || i != 0) &&

Why is only index 0 checked against the end of the table? Shouldn't
int be an invariant that all timer descriptions must not intersect
with the non-variable part of the GTDT table?

> +			platform_timer < acpi_gtdt_desc.gtdt_end &&
> +			platform_timer + gh->length <= acpi_gtdt_desc.gtdt_end) {

Surely, assuming that length isn't zero, if the last term is true, the
previous one also is? And what if it is 0?

Again, you cannot trust *anything* you find in the ACPI table.

> +			platform_timer += gh->length;

You are also reinventing the wheel, and repeating some of the worse
constructs in this code. It would be much better to build on (and
augment) the existing primitives to make the code *readable* instead
of being this pointer soup. Believe it or not, there is some value in
abstracting things.

I came up with the patchlet below, very lightly tested on my
Synquacer. It may not be optimal, but given that this is used exactly
once per boot, I'm sure we can afford a few extra comparisons. It
makes the iterator robust, and then uses that to implement the checks.

	M.

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index c0e77c1c8e09d..dca814183cc5c 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -36,15 +36,24 @@ struct acpi_gtdt_descriptor {
 
 static struct acpi_gtdt_descriptor acpi_gtdt_desc __initdata;
 
-static inline __init void *next_platform_timer(void *platform_timer)
+static __init bool platform_timer_valid(void *platform_timer)
 {
 	struct acpi_gtdt_header *gh = platform_timer;
 
-	platform_timer += gh->length;
-	if (platform_timer < acpi_gtdt_desc.gtdt_end)
-		return platform_timer;
+	return (gh->length != 0 &&
+		platform_timer >= (void *)(acpi_gtdt_desc.gtdt + 1) &&
+		platform_timer + gh->length <= acpi_gtdt_desc.gtdt_end);
+}
+
+static __init void *next_platform_timer(void *platform_timer)
+{
+	struct acpi_gtdt_header *gh = platform_timer;
 
-	return NULL;
+	if (!platform_timer_valid(platform_timer) ||
+	    !platform_timer_valid(platform_timer + gh->length))
+		return NULL;
+
+	return platform_timer + gh->length;
 }
 
 #define for_each_platform_timer(_g)				\
@@ -155,8 +164,9 @@ bool __init acpi_gtdt_c3stop(int type)
 int __init acpi_gtdt_init(struct acpi_table_header *table,
 			  int *platform_timer_count)
 {
-	void *platform_timer;
+	void *platform_timer, *tmp;
 	struct acpi_table_gtdt *gtdt;
+	int cnt = 0;
 
 	gtdt = container_of(table, struct acpi_table_gtdt, header);
 	acpi_gtdt_desc.gtdt = gtdt;
@@ -177,7 +187,12 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
 	}
 
 	platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
-	if (platform_timer < (void *)table + sizeof(struct acpi_table_gtdt)) {
+	for (tmp = platform_timer;
+	     tmp && platform_timer_valid(tmp);
+	     tmp = next_platform_timer(tmp))
+		cnt++;
+
+	if (cnt != gtdt->platform_timer_count) {
 		pr_err(FW_BUG "invalid timer data.\n");
 		return -EINVAL;
 	}

-- 
Without deviation from the norm, progress is not possible.

