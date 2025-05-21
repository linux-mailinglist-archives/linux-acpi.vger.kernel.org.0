Return-Path: <linux-acpi+bounces-13842-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15573ABFADB
	for <lists+linux-acpi@lfdr.de>; Wed, 21 May 2025 18:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85A31891D68
	for <lists+linux-acpi@lfdr.de>; Wed, 21 May 2025 16:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB0A281524;
	Wed, 21 May 2025 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQ3DzUvr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12B528A1F2
	for <linux-acpi@vger.kernel.org>; Wed, 21 May 2025 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747843136; cv=none; b=NaRT94Q3JvLTS4s604T2KUmtEQcAe9CHfo37o5aOIbFN+4Vzd2UH++MaWlyYyQPT4VZ7+gZ4Ixtl/S5YYH0yx3VLtxwS5BrvgNwt4Lx6X+XnJuW6WctGIAIaXOCxHGsi4j7QGs3xyPsTNgd3RNM3GdJRMZREQEU0bip2NKkYNUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747843136; c=relaxed/simple;
	bh=5+T8GTHcN2Kuz6CaX0w3iMNFuK4+py2zrcsMcPNUFJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QPI5PnHoxNKVEkrkwpZbTVJM2eJIR/09OU2kUKUVpvXt/m+52akkn/SFN41ITizl3EkPQPrYQ0haXkVriMBI+HtKXGiE8lxg/7ZcJs1o9x6fJoqkgumR8a2tFu4ROCTDXuDcjAAzp5t/B2xbN7fyydYkvS6Guhlw922SeUoUjjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQ3DzUvr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-442ec3ce724so57798085e9.0
        for <linux-acpi@vger.kernel.org>; Wed, 21 May 2025 08:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747843132; x=1748447932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gszD8DxK/QJXTJSJJ0pI3vv/hb5ULbF271EMSl7cRgQ=;
        b=iQ3DzUvrXmj7QzdHnsegANdf0jc9HSVyoBNjZTmJtcHiaiFJsceBpnIYwrngmmR3J3
         E4qOpP64a9yhPvZdNrT4GtZLksqsy58DM1+a2XSzSMii8hsvO9MxzCyH430t6dHNr1T6
         SV4KWH5qNhswzzcBqE97PKQOYBgtTHFG5eb8rwsCRbROpUUysb64TBbIrqGNSNNxzeJ2
         LbZVwczSUT7MT26I9AnxP47r/reVA4H3ZfyysYe92D3zprFQi4gKYZaG7wre4c4J664U
         6Y/gH//97ZANcuAxB2zC7Mhbg4XAwCElEmJbeoaDCl4YGSltjTxVM9NMsWuVB1LmZkC/
         y3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747843132; x=1748447932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gszD8DxK/QJXTJSJJ0pI3vv/hb5ULbF271EMSl7cRgQ=;
        b=RVkd6KzoBZICyE9R48YFIERBZNvdohfnS10BrtVeYqmMTbILuck5hKJqKLqbZCKJxl
         eNOVWFs9W1Xx3VAczl78ywNpXcymZ7XA87Q5mpz1VwPHj1TguVKOtEwD3M9Das3TkDe5
         qaci8R4FXwnkhOy5fdMweGh0ctjO9eo6fSfxcWQEy1/NQxEKOH+qJ53nttWOZZ2aluoX
         UMBFRBGVbyCxUH+Vr3PP3kpxOpk/UaonAwIdALzeic8nWN8wKFJ/OmWaLaxdtfkjU7re
         h1oDXOPVe5J3VdXs3MfO9tEHl1+mwWiO78OPJR5BXQeMaHnDl0cwIjyC/BfdNNGdYxPg
         aP+w==
X-Forwarded-Encrypted: i=1; AJvYcCXmK6LH6K/V9Ttxmfg6wQV4vKDH5ULHAg3mWa0isErguAegoE/AEl10gbgp49nyWTMd6LcO3UoI+zqe@vger.kernel.org
X-Gm-Message-State: AOJu0YwoVub3asJYjeQK7RbQn8sENQDNAB7hWZ/FmtS4T8OCq5M0LPO1
	iW62Gtz+v2/ajlT0YNT2PqRcEUhrPFmjkcaIIAwsRoE4Il1oQb1c5H08
X-Gm-Gg: ASbGnctzChW/6/NLw6SrSj8/0K44AEr9jGUVpd8B5IFvS1mi2vubKrqZtoOsrih0WDH
	uI0GaTsuA7Vr4CXGu1DMigJRuMwE4jgpfAjoJXT/Aom9NfsGv7Sd+jcRDlxBncrw/KOmQxzl1Nd
	t6Ra90rynzLYhWSxjVTLEGTizp+pU/imsFuFp2Q2lRCbmdBGB5zggg0BKN2BAMgogZp17RXLH2a
	gZppxufH9QdHcDRWzLa76els7jMZ4kDdwA1FbPZydKC2C/m9ZzHNbifUn3DzEU3KHQMqhIIm/HV
	eigTugdhu2PtSBnJOFJcGYjh7d40nyzzhri1RAjhriPn1I0DSoCuNVw+JwuVcZ4=
X-Google-Smtp-Source: AGHT+IGjt+tgPME2C9K/SJUnMp5BEwfG8pQsZa5B2z1xYKBqj2V1u/YCvGhGgjGSJatBpF3CFRDr6A==
X-Received: by 2002:a05:600c:a113:b0:442:ff29:c2f6 with SMTP id 5b1f17b1804b1-442ff29c404mr178921795e9.13.1747843131872;
        Wed, 21 May 2025 08:58:51 -0700 (PDT)
Received: from localhost.localdomain ([78.172.0.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6b29633sm78652695e9.8.2025.05.21.08.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 08:58:51 -0700 (PDT)
From: Baris Can Goral <goralbaris@gmail.com>
To: mjguzik@gmail.com
Cc: acpica-devel@lists.linux.dev,
	goralbaris@gmail.com,
	kees@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	lkp@intel.com,
	oe-lkp@lists.linux.dev,
	oliver.sang@intel.com,
	rafael.j.wysocki@intel.com,
	robert.moore@intel.com,
	skhan@linuxfoundation.org
Subject: [PATCH acpi] Replace strncpy with strscpy
Date: Wed, 21 May 2025 18:58:49 +0300
Message-Id: <20250521155849.13783-1-goralbaris@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <rkc452hxtxcaym55croa5uvtjjsulbl25bhdk2mw2ce5fwqx4p@guhdxk6eogqj>
References: <rkc452hxtxcaym55croa5uvtjjsulbl25bhdk2mw2ce5fwqx4p@guhdxk6eogqj>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Mateusz,

Tyring to understand your point. Why the customer want a string or
an ID without nul termination?
In your case, you put forward an idea that "the thing is NOT related as a
string, instead it is handled with memcmp".

My idea is:

For examle, the variable "signature" is __nonstring so, it does not necessarily 
contain a terminating NUL.
[snip]
      ACPI_COPY_NAMESEG(header.signature, signature);
      strncpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
      strncpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);

[/snip]

But the others, oem_id,oem_table_id are not.
So they are strings and deserve to end with nul.
[snip]
struct acpi_table_header {
    char signature[ACPI_NAMESEG_SIZE] __nonstring;  /* ASCII table signature */
    u32 length;     /* Length of table in bytes, including this header */
    u8 revision;        /* ACPI Specification minor version number */
    u8 checksum;        /* To make sum of entire table == 0 */
    char oem_id[ACPI_OEM_ID_SIZE];  /* ASCII OEM identification */
    char oem_table_id[ACPI_OEM_TABLE_ID_SIZE];  /* ASCII OEM table identification */
    u32 oem_revision;   /* OEM revision number */
    char asl_compiler_id[ACPI_NAMESEG_SIZE];    /* ASCII ASL compiler vendor ID */
    u32 asl_compiler_revision;  /* ASL compiler version */
  };
[/snip]
Otherwise, the writer would have added "__nonstring" keyword.

Best Regards,
Baris

