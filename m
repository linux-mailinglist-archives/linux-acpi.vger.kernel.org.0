Return-Path: <linux-acpi+bounces-12732-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA60EA7B8CC
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 10:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB37189BE06
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 08:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29451990B7;
	Fri,  4 Apr 2025 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEuhqAAt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A34194C86;
	Fri,  4 Apr 2025 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743755120; cv=none; b=gwGgMAMJZHYSU20rqM/0uFXdVhE4olnwTey7MllHOiWClEaV3i0wpwoCJ8wXik1ZC/lDG9k+6ku/YCNy+SKmwyWGO+D0unUgm5lY4BIj4bbfOpOqYU3ZtE9qKIHUGQ5FI2cf6aF/hTvAFVlNVCc9dpfUT/ae8rDbuAF6+Z+Zw+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743755120; c=relaxed/simple;
	bh=ki2U4QAPiVrOPCNE0sc9O7MbbgjVfkGGaNGHNTMHOsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnW0JUhRYNLZ1E2qjINazM//Zj7YdoeZWZ8HwzbSRkzko5p/m4/X6C5TjemiXDJM7KOTzPPC3N1EfsHKl3Akm7c37KhaqX5FDwc02NMp5vWO3EbTSHXZokHo7HZvlG4kRdgNSL4rX5PkLCwhavaqBKCoeOsVlO0BZa+Y6syMj3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEuhqAAt; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso293803766b.1;
        Fri, 04 Apr 2025 01:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743755117; x=1744359917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zryx7ad32NdBny1P05+MPUD/OPYaqir+9vR64JjAn9M=;
        b=CEuhqAAtUNAznHqKC5NlYVYMd8tG+54q6hC5cOen2GoQ8hQt3guYB+2NWB+bG1BaWE
         vafbZWpT+uLZj5mstP5srH7WkEeApIVn4jYeM99nmV7w0bLELcCey2lpdkEtsSnK7neo
         rD/iAk5MOnnqnBcdfUmLo3XpgTpoqf02ug5GeZZSPAnugS1UGn3L+dfHVjYtEr6yDxlU
         J/SZuyL2CLYzzzcJShSya7be7JEHrGKLobT27xKv735ARGFw3pefwfyLa6IKQkKLEG/T
         l7ELx9TbTC7QIvY7m4Mlq6UzzbIABJYHMJT3TpczFrNhtkEAtp2r4xa0dxZWGHNFLxWW
         MLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743755117; x=1744359917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zryx7ad32NdBny1P05+MPUD/OPYaqir+9vR64JjAn9M=;
        b=L299s7GcJrH1R7KpGuMJaY4DUGC9V6bOTKz3Kjrti0gki6dBMler2PNMfIMC+HU08I
         nAKXUlxQfZLY32Ht/kFvWooT+Gr6yebgnbDjz1B+B/YJkbRZiHCGTdKmTlmTM3e5wnPm
         oBSp3mSzZ/YKT/56ZFHdLE+6RtCOaucdlKdMka+ZWju9SkXokw5fYgyV1IhXwKTcsPlq
         vOcdqcrn9ulrxwPDbpaLgLC2f8Gm5oRPaa/+OnZ6aRzor2na+aQS/ZwPJrTYv0Rl8acA
         X4kBoPFvvWisKnj5XNkfsULfU14w6Egd18cB40PMaw+FUdGyc/Qlav2dprK3edRoqIgt
         pD9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+6FST2H38WgdQGJTUz4SH89p73tclitd95S2rSxvomlRqWosfrfbUee7CxEghy0b51TmKlcBp4h/fjB80@vger.kernel.org, AJvYcCXKicxzBLuDLyJ+BuMLWX3egTb3weC+dO8gyL1Law8TvuVNX5EaySap18+zqNwANe/0PqzkFrUdjveg@vger.kernel.org
X-Gm-Message-State: AOJu0YzKrgwWXk7q2APyfvU7oRUNaypfOlUhc1Styqugye3CagSohNHx
	+HLksXxjzEtdOcSyZSuuFUGTAokBgZrVvaYto4ehHdAGjP9VOV0w
X-Gm-Gg: ASbGncuQR8vtDJeI+p4mihKI1A1eFCt6wfiLF6wxmJtQ9lz8VzJNgl1JX6Uetxvx1LB
	P16XZa4Q76i7QOqxOOwQZB4xFoTDcSCVKomQuJeZy4/bQRCMZ1SQcgkh7zWxbPB5LnxldN52SPP
	3EHtImgVTKAfELxz4yT5w4Nfab88u1FfAhMoekzSzkay+oVrHXzdNp4f9004SyYVrDXuFqT+QHS
	9G7fMc9A57P2MexaOvUHbdT8XgFlqokUMVgq/W9IONdc21Ae5ZaGwPYtm5BuIzJgAKqisJOSFdl
	6zdEMRTyrvj238om1XiEG+gG35QSe7QcwA==
X-Google-Smtp-Source: AGHT+IEYtKEnGZ39GvMbcfj0wNEB/Y7HPIe4XJ9Z3n5OVfb4/JVz12XWbpPUjW0OK75Bv0H17r1gBQ==
X-Received: by 2002:a17:907:8688:b0:ac3:c59a:413e with SMTP id a640c23a62f3a-ac7d6ec546dmr163533466b.55.1743755117074;
        Fri, 04 Apr 2025 01:25:17 -0700 (PDT)
Received: from localhost ([95.85.21.12])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac7bfe67e17sm216029466b.34.2025.04.04.01.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 01:25:16 -0700 (PDT)
Date: Fri, 4 Apr 2025 10:25:14 +0200
From: Ahmed Salem <x0rw3ll@gmail.com>
To: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc: skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ACPI: PRM: apply ACPI_NONSTRING annotation
Message-ID: <00f4b71ec859adedb34bb33b05634cc1ae97cfda.1743754416.git.x0rw3ll@gmail.com>
References: <cover.1743754416.git.x0rw3ll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1743754416.git.x0rw3ll@gmail.com>

Mark ACPI_COPY_NAMESEG() destination char array with the ACPI_NONSTRING
annotation. prm_content_buffer->signature[ACPI_NAMESEG_SIZE] is 4 bytes
long and not expected to include a NUL terminating character.

Signed-off-by: Ahmed Salem <x0rw3ll@gmail.com>

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index e549914a636c..7c2553696dd1 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -40,7 +40,7 @@ struct prm_buffer {
 };
 
 struct prm_context_buffer {
-	char signature[ACPI_NAMESEG_SIZE];
+	char signature[ACPI_NAMESEG_SIZE] ACPI_NONSTRING;
 	u16 revision;
 	u16 reserved;
 	guid_t identifier;
-- 
2.47.2


