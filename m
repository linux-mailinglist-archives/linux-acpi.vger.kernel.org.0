Return-Path: <linux-acpi+bounces-2615-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF3381E96B
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Dec 2023 20:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E3B8B223C4
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Dec 2023 19:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF9F18C3B;
	Tue, 26 Dec 2023 19:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="StZuggUn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CF91A29D
	for <linux-acpi@vger.kernel.org>; Tue, 26 Dec 2023 19:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7b435966249so207201039f.0
        for <linux-acpi@vger.kernel.org>; Tue, 26 Dec 2023 11:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703618541; x=1704223341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hayCP5oXfqDKr07tFyakQH54fYrG+Ow3QZu0J2xcXzk=;
        b=StZuggUnNz23lHyZFp6NWdfArrQBiAGQSLc2ZuHNMQ9vZwySx2fpfN9rh9h/CC0DFJ
         m8bGWASmvPi30tdz8wssd87MY2gqQg7UAXiFozlqSrNqgkHZsZSFk7wS/ZsiDOXq0rsg
         3Y0XzraEOjVxpT9tyMlCNnapSpdok+QTf340A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703618541; x=1704223341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hayCP5oXfqDKr07tFyakQH54fYrG+Ow3QZu0J2xcXzk=;
        b=bvShkOkssf0urwKz4ixl6FRscfAyTM99TpYnzGZSy2CDR5Xxk985NNVGVIWvk5ih8U
         zKNZMZjCRr3fl8R6mHOGHtWAKy9L4SkAmbtSSrsmNkK3oSVdeEEHlEfweqLkcy+mEtXg
         V8fga//zdztdccoNb+dL2hbfSxnA7dqKcl0/Sm8HBsRqpDV4yrAmbQpU5EmkBgu2nR4u
         jtY7GmridU/y5Q3TB7X1EFTIGKA8sYFkOOTruF8TIivcMZYZCc5QEAPw+KgrpF63TeaH
         rxnRWMnbxEwjtYCJ+V0KTgLNWkWRNuhtMn4gc7EnKZ0eRDp67kFfyhnOK8Izoue7xM18
         CDXQ==
X-Gm-Message-State: AOJu0YyccMB3lRZ9QJIGcaBqpyD9+eOM6+86lwnzj/Yehz/wg/F+OmLw
	PCRqOcn63g3J9fNZRlAMLIjV/lSW4s2r
X-Google-Smtp-Source: AGHT+IFlHRwPf/8jJo+Ae9mfDpUSRCg3GFEPLZrL7XWaov1wJ5hGOO4inSD1xWUk2IDucTfgcb2/6A==
X-Received: by 2002:a6b:f008:0:b0:7b7:4c36:f295 with SMTP id w8-20020a6bf008000000b007b74c36f295mr9063772ioc.40.1703618541107;
        Tue, 26 Dec 2023 11:22:21 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id gw3-20020a0566381ee300b0046b692e719esm3207609jab.150.2023.12.26.11.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 11:22:20 -0800 (PST)
From: Mark Hasemeyer <markhas@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
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
Subject: [PATCH v3 22/24] device property: Update functions to use EXPORT_SYMBOL_GPL
Date: Tue, 26 Dec 2023 12:21:26 -0700
Message-ID: <20231226122113.v3.22.I186bc5737c5ac4c3a5a7a91e9ec75645e723ca7b@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231226192149.1830592-1-markhas@chromium.org>
References: <20231226192149.1830592-1-markhas@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the exported functions use EXPORT_SYMBOL instead of
EXPORT_SYMBOL_GPL and are inconsistent with the other exported functions
in the module. The underlying APCI/OF struct fwnode_operations
implementations are also exported via EXPORT_SYMBOL_GPL.

Update them to use the EXPORT_SYMBOL_GPL macro.

Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

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


