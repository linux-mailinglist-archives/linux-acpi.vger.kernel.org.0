Return-Path: <linux-acpi+bounces-18090-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C13BFC3B1
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 15:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C126434A305
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 13:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF1126CE2D;
	Wed, 22 Oct 2025 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wvFdPYpq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC8C348472
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140475; cv=none; b=Lq+N9XqmWueRv9X3p9e4w6gjPdYNShz/fp8JIKrEY0FJQJeoatUf/09JPRvlEWxC8bF6vq0Jn9ZZ1enEnT9CBGCYkjboKwoSeJ46YeJ1rwvpOI0uGuDXPjA/KHq0Bao4dg6LXaKeE3KJI4SjhS3rB6k2q0+WDmI+3Ing0PIi73o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140475; c=relaxed/simple;
	bh=KtuXavFSO+yHts6nDETGFNophDcbvASbEqMZFzPoklc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c4YKzanKgF8l6yCIdrVMYWsn5LeodjxzPtC+c9iYHiX3RQTKreiy/TuURP1l5GcXA0Q0vRV2GIdcGZAEt4vrBW2iGbC7GC7Z2ftLDh2Db+AH/hvm1KG6Y2z53N16yScYyqRoLw5gL1ers66gjnEdqj5DzyvkMQTzzDbpz6u1qw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wvFdPYpq; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-427007b1fe5so4589377f8f.1
        for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 06:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761140472; x=1761745272; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mMCGgThfY+V0RirzP1gdBriZ/f2hZUs3X0MJBzFD4qQ=;
        b=wvFdPYpqEoMl0j2A4uRIM+FWd/fKu4IscftCw6k+SLqQ1Qr9d1/oa/HI02XepiRTqx
         WyDXQcnhjDywz5rXbRU0+PRHpvo0Go1/3WpqY5cyKUTJOc3mm7XohuueFqz6w7J61+6Q
         81tPHBedPCf+bESsjxBJxO84DZsXrWvZiQ3sBmd0DLtUBgNC4S0PrREjneOrMPbPe3eo
         S8DJuZDqDOJxcvAK2WmX1zrIVmWO3b3eUvYxq4Pb7i/57kr1gyJ63v1FF4mv/IKFaF3M
         ZdKplfRqcI1LfK4CciJdZnncOtMZRuFw0mCi54ECJ/DZDbWToOBnPxgnlVQs5wgrWtn7
         /2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761140472; x=1761745272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMCGgThfY+V0RirzP1gdBriZ/f2hZUs3X0MJBzFD4qQ=;
        b=pWfe40fvw6Y1e0weIlSzfaucoOENLc0sMsklKnr62A3e4rma4ES4rV5LMsMRXJkejt
         jeFIBV+t4DJaBDBgY1p/+cMWUvHTfvssGIo3+Cd9Y8UYrK+ET2hQjNUu0B16EOgs/d1B
         zo8Ky0D/pDKQArnOVuaWS6XhDXMGSmltFQ6A/n9L5bI9jvskkwK8zbMLZqKtAbhvUGS7
         TGmRbLXdHIyaoajBqGp4uVqWxMTIViwns3k9H3uC3sz8+UNfrCev3nA2QN5JIfXgtRxs
         pOPmz/pnI77VMm0DA3k5a9WfBcN/u8wZE4fSRRlp6zgWT6b+YviiEkffE1bXoLzChlvc
         FC1w==
X-Forwarded-Encrypted: i=1; AJvYcCWkBVKYNIhdNEbl/0uTCmqjWg4Qd7Lgeemed9dKHINhhsESyPN11HzFLMCJqTpSKlgAnmRfxvlIE6Hj@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+mJKWDLwEHirpwUwypYFApAT2RWHNH3dIj7aq15cAW6wxEmR+
	S1DjSyn6GU8btyh2VKzpF7ItV3HsGWYsiy6FgxDECCglkgn847hCNVCC5jIPsOpZbtQ=
X-Gm-Gg: ASbGnctUDHTEOQe0mkMjRGWgYkWEe645zE3t8JMGydQ+OXpcGZOabkR4GrzzkgnZSyN
	Dm3Rvji/l2QC920IuR/QjOjRr5hy1Hd26rAz4Khkb2MNfwLeA7sUVW5lIiylJCpoOB8vmBpqfHj
	5KYSEqhJ9z+yFvrJhuXfOAhm/pv47FrPKuUyPAVYUlqk9YzO/DTzUW/sk58QFZQVWkllTi6OE0R
	xdirVXxAs6HzhhcrZFp3oRv5Jobq7hSDW7E5DXxsD2guJq07yH58a2lm+OEGNvw/X8eVBDLyCOq
	w2/bw3Irzu8CYQy5d7v+OKZHTTVm9AiAHsPfi2b38QRGO9Np3NV6v+Vb4zzA2HKEkti5brhTWio
	v5VUvtQn+gPin7OaUla5pCyLv2RU8yq9+ZmHbRzR80fgplaTTUIaxvdYBmmNBAldIIMHu7MiAFc
	egVTjngw==
X-Google-Smtp-Source: AGHT+IEWGkNv1ghBf/K2OQ+bJlk7L3ZBRKiBQs2VoGJ1Nf+CsDJ+02T15fTRy4Ca86xVVpT2D117Ug==
X-Received: by 2002:a5d:5f48:0:b0:426:ff2f:9c15 with SMTP id ffacd0b85a97d-42704d83d04mr16052655f8f.5.1761140472122;
        Wed, 22 Oct 2025 06:41:12 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69df:73af:f16a:eada])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b97f8sm24863066f8f.36.2025.10.22.06.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 06:41:10 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 22 Oct 2025 15:41:00 +0200
Subject: [PATCH v2 1/9] software node: read the reference args via the
 fwnode API
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-reset-gpios-swnodes-v2-1-69088530291b@linaro.org>
References: <20251022-reset-gpios-swnodes-v2-0-69088530291b@linaro.org>
In-Reply-To: <20251022-reset-gpios-swnodes-v2-0-69088530291b@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=987;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=4gUQtx1OPTw/Dg97I3rmMZzhZLKCx62HjY4kgfolpG0=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo+N7yKCCEFjEmVRu6hBBLG85svY7H3gkvZZZ/e
 4JsWArxqYWJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaPje8gAKCRARpy6gFHHX
 ctG+EADVuYvKf7J97Xfy6aPL28SA4xG3bpblIA1iPGZqVfNpzaJMDJ+GbioeJ89alKEabDaWzYU
 w+ruZFxwFxZSIOIlrk9lFkeTTghOpDC4WDz+xSIM5VpshSj/atpXW6rzkn7TVOWiT6+8VPkD6jO
 e1fEYlT094ITtK1mYEz4GNkJ8TnWEXA0ShhTnnMWxbG7kpKeHwW6InHRWh+LE8kpiogZcn0Vost
 OCtNeLk2w19sTzReWmxSY/t+tOafQJh+aIfXJq4jR6MCXz1C9XXjXEsvWiNoMAT9sBxtZE6Qp8+
 FHKNRJWjI58010OxchcYnesnC0tPAjMaOPQoIwuI9awNJ/9KX0W8iC3iBhkH5WtKPHc1bLJvJgl
 93IhaHIFmlihFrerp+KYrx5rX5KNLgjSLF1F+wP1GlfbKqHXzTMby16oWXAWhiwbmEYD/zIlqI8
 udCZ0CYQZMxip4iLPWZacXQg8PQ2FELWQGh6KU/PUsfe8MxlPlB0S7jZrVOtDJ3uny3tsQGw9kn
 JdXnSS57uEsLuE/cA3QAfq5YSvddiLa8aH/ty7FgMCMiQ3dscHtTrDenb7jqeCJjjJMDEDXpP73
 FEX06fRq5Q7/W05Y3XBNiBtoiaDoCorZIceSRiUPc6bMWWNgNXXTNBcZyeu+PWTnCG0Dgfn8x/A
 31KICtJHlMq7WNg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Once we allow software nodes to reference all kinds of firmware nodes,
the refnode here will no longer necessarily be a software node so read
its proprties going through its fwnode implementation.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/base/swnode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index be1e9e61a7bf4d1301a3e109628517cfd9214704..2994efaf1d5d74c82df70e7df8bddf61ba0bfd41 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -540,9 +540,8 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 		return -ENOENT;
 
 	if (nargs_prop) {
-		error = property_entry_read_int_array(ref->node->properties,
-						      nargs_prop, sizeof(u32),
-						      &nargs_prop_val, 1);
+		error = fwnode_property_read_u32(refnode, nargs_prop,
+						 &nargs_prop_val);
 		if (error)
 			return error;
 

-- 
2.48.1


