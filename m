Return-Path: <linux-acpi+bounces-2675-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA72822322
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jan 2024 22:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059271C22B6B
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jan 2024 21:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7846619465;
	Tue,  2 Jan 2024 21:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HH7tFOjr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FED0199B8
	for <linux-acpi@vger.kernel.org>; Tue,  2 Jan 2024 21:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7ba87489f97so485590739f.1
        for <linux-acpi@vger.kernel.org>; Tue, 02 Jan 2024 13:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704229743; x=1704834543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCG4rEgr/FQR7hxUStyYKIoU69lpCt3KIAVsm7R5chw=;
        b=HH7tFOjrAQTrdWIDJwg39s5pkcy+elPqqdPyYMArPhsxRixM6h/JAHq2NBec+JYJFq
         FTxNbr7+7HxnH6nIBXll3KHOSWFKmb+e2ZSYN6iUv/i8s3ZhVyaO0l1Oxxt6C/22osve
         gvQJlJC5UXoxyrkSr6+QTVvy+fITN4RdMHCdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704229743; x=1704834543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCG4rEgr/FQR7hxUStyYKIoU69lpCt3KIAVsm7R5chw=;
        b=l+ukE5rYC9YJaqNRVufz43rnveSAyudzOI65DiMm/FCwqOJ1ouvZvMiJkYmlwUcR0i
         ZewN9rfQaibc3x/OpQXFf7znkJnVPN0wofoAl9D3IiB8KRLYwVVw/wLf/OAE/eI0jLkS
         0+U+fr8DzYnd8U+q3tPKK18ABWTG2gv81wyBvyNR1Pzp+BiFIG9ObooYHsG57JXN9lK6
         Y7Pvoqu8qv5wOUAM0v3bZEaAOU4Y5X0vG0LxlZiMkFBPXSMA/kWTRqgjNFzomOBN3uAm
         P+RIX5I/ptBNdRnXRJ3PZ7qRXOTXuDjAhfjMpuOyHt9XlarujNV+Xp/lk18hBmaH+gOA
         wHRw==
X-Gm-Message-State: AOJu0YxtT1IKw/V1PveO2rr06zDWjxokUIkaNp//JH+c/XPXzff5yweQ
	iVdOkfAeQysTeXU3ZUqD6jiHGlQQYRRo
X-Google-Smtp-Source: AGHT+IEYPIgR5pi2eeLco54E9c38X2wwM4Cn8EJ6pMdLsbQ/1JjnSZUs1p36vbx1tnUTzVouFENiDQ==
X-Received: by 2002:a6b:c996:0:b0:7b7:fe2f:dddd with SMTP id z144-20020a6bc996000000b007b7fe2fddddmr18896089iof.22.1704229743320;
        Tue, 02 Jan 2024 13:09:03 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id bo18-20020a056638439200b0046993034c91sm6956978jab.77.2024.01.02.13.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 13:09:03 -0800 (PST)
From: Mark Hasemeyer <markhas@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Raul Rangel <rrangel@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Mark Hasemeyer <markhas@chromium.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH v4 22/24] device property: Update functions to use EXPORT_SYMBOL_GPL()
Date: Tue,  2 Jan 2024 14:07:46 -0700
Message-ID: <20240102140734.v4.22.I186bc5737c5ac4c3a5a7a91e9ec75645e723ca7b@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20240102210820.2604667-1-markhas@chromium.org>
References: <20240102210820.2604667-1-markhas@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the exported functions use EXPORT_SYMBOL() instead of
EXPORT_SYMBOL_GPL() and are inconsistent with the other exported
functions in the module. The underlying APCI/OF struct fwnode_operations
implementations are also exported via EXPORT_SYMBOL_GPL().

Update them to use the EXPORT_SYMBOL_GPL() macro.

Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

Changes in v4:
-EXPORT_SYMBOL->EXPORT_SYMBOL()
-Add Andy's Reviewed-by tag

Changes in v3:
-New patch

 drivers/base/property.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 441899171d19d..4f686516cac82 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1044,7 +1044,7 @@ void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index)
 {
 	return fwnode_call_ptr_op(fwnode, iomap, index);
 }
-EXPORT_SYMBOL(fwnode_iomap);
+EXPORT_SYMBOL_GPL(fwnode_iomap);
 
 /**
  * fwnode_irq_get_resource - Get IRQ directly from a fwnode and populate
@@ -1082,7 +1082,7 @@ int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
 
 	return fwnode_irq_get_resource(fwnode, index, &r);
 }
-EXPORT_SYMBOL(fwnode_irq_get);
+EXPORT_SYMBOL_GPL(fwnode_irq_get);
 
 /**
  * fwnode_irq_get_byname - Get IRQ from a fwnode using its name
@@ -1110,7 +1110,7 @@ int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name)
 
 	return fwnode_irq_get(fwnode, index);
 }
-EXPORT_SYMBOL(fwnode_irq_get_byname);
+EXPORT_SYMBOL_GPL(fwnode_irq_get_byname);
 
 /**
  * fwnode_graph_get_next_endpoint - Get next endpoint firmware node
@@ -1355,7 +1355,7 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 
 	return fwnode_call_int_op(fwnode, graph_parse_endpoint, endpoint);
 }
-EXPORT_SYMBOL(fwnode_graph_parse_endpoint);
+EXPORT_SYMBOL_GPL(fwnode_graph_parse_endpoint);
 
 const void *device_get_match_data(const struct device *dev)
 {
-- 
2.43.0.472.g3155946c3a-goog


