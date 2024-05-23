Return-Path: <linux-acpi+bounces-5967-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D59708CD792
	for <lists+linux-acpi@lfdr.de>; Thu, 23 May 2024 17:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94B961F22612
	for <lists+linux-acpi@lfdr.de>; Thu, 23 May 2024 15:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4645B15E81;
	Thu, 23 May 2024 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuVmT/KV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8274012B89;
	Thu, 23 May 2024 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479256; cv=none; b=QFcMt09v0aS9IiJgX+Lrs62RPiQPdeHLBoYhkJpAJBcG5b6DQ31ZMYGTHZWig9HzRnPPKCE/XfWz3JswfWq7ASu63HGz0QlKhO/GYSXouwdO9qcqKxRiNS3NyRR92+z1l3x88jBbSyRx33LgI0xjI3uyH5XJQiE3Lq0J/ohWZKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479256; c=relaxed/simple;
	bh=9hWCfjhhVw3iKm2K8ZqqBvjv4a6eCuEbOteQFItL/So=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R3MiuON/NR11eKjT4DEQxizPKkKdhAr2W8w+B5YPIEemwlWQPJqt2mdBejxNAMwFIDRvWCaoTOyPliK2TNCTE+7p/DaAKMGe1A5zkEIj6kEE3+y6XbzsApiCbWXT4AOUPw6PAEbispuN9C5zcT6PuVDxycEZBtLLGyRJuktIJng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cuVmT/KV; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e538a264e0so108862031fa.1;
        Thu, 23 May 2024 08:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716479252; x=1717084052; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9FQyjhPHmXpcdMO6VzbCHP+i07w7eEawaXliufyJqc=;
        b=cuVmT/KV2WeCiMH6xcRrAlmCO5RrkFkUtiK6sTQWtJL1ESx1VXVqyJdKW1SIP042IN
         +Py+4BstuNmsOZlgQnAHUKlZkQOnpQN+3bhpA+QxhgAGfs1UuZMBE9nBqIVSiL9exTEv
         ELYO5mS9mE6w5xuArYKnG80bIVndQhEpUXcBfl7syfqbvM1hMT6CElg7VDbhtIZ5lQhi
         aa8Q7uiRQORf9SzAwSz1OZcT35puaU9pu1KKeark5RxJ/PsEVug8cAzMM6vOAE18qqJs
         ZCWTleCXWKLiVbu1zjufUsk/wt07/TekhTmXuHaCwgrQ2Bv5ltl+3Z9pQhvNnNvXAamW
         Y09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716479252; x=1717084052;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9FQyjhPHmXpcdMO6VzbCHP+i07w7eEawaXliufyJqc=;
        b=Jqmvlx/eq0+EqBSHW8m1YA6Px8G7N5+ZmjFJaqelMXNon2hp3cC+i7q0KrXY6VOM1Z
         YCalN6mAOLUH8JBzLzm5qGkEMeEbADEKfB1YVROrcnPnMEsmCID40F8ugPAKtYFxvP17
         4f7ZnMXHcnNoOREcBH9VbzzlA6LUpmboZDDjsIiOIJJ60IVrxd5Uj6P+IBFe2Um9PWSP
         rTrVnbIK0S51no2CWQhfs2n6w+jxcJzDRVTWEDAAbCmycs6SOiA9Cwtqh8eLacoBnAov
         yTq14S9jhVTPUKYR8MtXa9Kv8+3KqGaUZAWvDwGxCyNBZW1JhZdH7RHet8pW0ip2XJL1
         iGCw==
X-Forwarded-Encrypted: i=1; AJvYcCW/eNMcsgdsNZM40WyWYIykS6T5au9xhqg9cDs/Xt4SBJfeDvmtGRznrEudHI+dvVigCqT+kEvjnhDKgp4nqVy5sTJ3U5jcZ8fmEIUEKIFBYfFBvsbS6KvFAVsSZfmwyKcTP3CnZk1wQ/dxMFgO2qkFsFoFazStCGBl+FXN1Jtpn6c=
X-Gm-Message-State: AOJu0Yxmvndc/atbq1prwPO9kmOVsfteIBved6aGM1ibjO+mrpGQsZWX
	jq8zZW8VpTMMHzmnVrLvk2oRe0zHBiYzSg04gQPOqgdqTLf/WcR9QOOwSlRnxL4=
X-Google-Smtp-Source: AGHT+IHOPon9/wAOsXX5ACXesmOWEvoSUCdGumsqH6LYPpDZhTFoVRQ0woENgeiNb4K33Fij75kDcg==
X-Received: by 2002:a2e:96c3:0:b0:2e9:555f:54e with SMTP id 38308e7fff4ca-2e9555f08bdmr16396651fa.18.1716479252157;
        Thu, 23 May 2024 08:47:32 -0700 (PDT)
Received: from [127.0.1.1] (84-115-212-250.cable.dynamic.surfer.at. [84.115.212.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f5a576sm28569725e9.22.2024.05.23.08.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 08:47:31 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 23 May 2024 17:47:14 +0200
Subject: [PATCH v2 1/3] hwmon: (ltc2992) Fix memory leak in
 ltc2992_parse_dt()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240523-fwnode_for_each_available_child_node_scoped-v2-1-701f3a03f2fb@gmail.com>
References: <20240523-fwnode_for_each_available_child_node_scoped-v2-0-701f3a03f2fb@gmail.com>
In-Reply-To: <20240523-fwnode_for_each_available_child_node_scoped-v2-0-701f3a03f2fb@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716479248; l=1134;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=9hWCfjhhVw3iKm2K8ZqqBvjv4a6eCuEbOteQFItL/So=;
 b=cUt3FVuACsgdaeqMx1ewYFxQ1Ie/fOsFuDfGfBu4aZmqq7BgBJhE2eksmLuECMRRrmBO9Cbkw
 ef60GlkHglgATzTHOWTG5DXQSnJI0IerCpJFdKAKFpw6J307tB7kbTw
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

A new error path was added to the fwnode_for_each_available_node() loop
in ltc2992_parse_dt(), which leads to an early return that requires a
call to fwnode_handle_put() to avoid a memory leak in that case.

Add the missing fwnode_handle_put() in the error path from a zero value
shunt resistor.

Cc: stable@vger.kernel.org
Fixes: 10b029020487 ("hwmon: (ltc2992) Avoid division by zero")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/hwmon/ltc2992.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/ltc2992.c b/drivers/hwmon/ltc2992.c
index 229aed15d5ca..d4a93223cd3b 100644
--- a/drivers/hwmon/ltc2992.c
+++ b/drivers/hwmon/ltc2992.c
@@ -876,9 +876,11 @@ static int ltc2992_parse_dt(struct ltc2992_state *st)
 
 		ret = fwnode_property_read_u32(child, "shunt-resistor-micro-ohms", &val);
 		if (!ret) {
-			if (!val)
+			if (!val) {
+				fwnode_handle_put(child);
 				return dev_err_probe(&st->client->dev, -EINVAL,
 						     "shunt resistor value cannot be zero\n");
+			}
 			st->r_sense_uohm[addr] = val;
 		}
 	}

-- 
2.40.1


