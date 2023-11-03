Return-Path: <linux-acpi+bounces-1170-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A31607DFF30
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Nov 2023 07:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11630281741
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Nov 2023 06:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDE779C6
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Nov 2023 06:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nurVtYuD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098141FCE
	for <linux-acpi@vger.kernel.org>; Fri,  3 Nov 2023 06:19:34 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E431AD
	for <linux-acpi@vger.kernel.org>; Thu,  2 Nov 2023 23:19:30 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9adb9fa7200so343684566b.0
        for <linux-acpi@vger.kernel.org>; Thu, 02 Nov 2023 23:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698992369; x=1699597169; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=doFmS+NCdefv1+ceez2+893UX2T0fe3mmg0dF9v1al4=;
        b=nurVtYuDUvf0qjhPpJ2PInK82ocvaKN9Z2jemMlQza4eqpaKUibhRx6RenZtzn4/Nf
         uVp57SlMkzjVA5G1YMTuDKQ1K/JsdZvprIjK1BG27nEx+5QOWi1wBn0HxB3+I+vWojjI
         JpmNlGFKGY9tiIf69GNRuHUrCHc+aGvvt/Dl5AOznPo2Y+TVhuciUHNoW8QE2HCsjODI
         pAgrHIKE86cYewdcPTiaTeYATh7vS4K51iH58YDoNHb6MtZvcle4a0WXCNQH8F6GOLwq
         Phc5VAHCfDTQRkZq5UGNAU5VCcs7pOUc9eOqhg13MWF4FLEJXPtz1J3miAZ+RQYwE8CQ
         JV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698992369; x=1699597169;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=doFmS+NCdefv1+ceez2+893UX2T0fe3mmg0dF9v1al4=;
        b=GPE7OX1LaFS8ELEdU5/zXmjZpOreaGtYgUgr/539jfQekHKHXuB5RRhHeYtEkrtIw9
         15papR+StMN9swGUCRpVgoua1d7zcNSWoc7jjWeP2SbrMUunJmZOzU8XAMlHYslPrJHX
         7eQ8bnH/7HZDxXpiByeEwZZQVaIQO3HB/Yjqq5XTQv6rhiPcUU793Uktdlkv8wkfcKon
         K39n/2Wkhi7g2x7bGvWcxhqS7WTm5/OZA/yFxPQ+a7+Kk2iFXDorCc2g8/LunTS/vQ/3
         tNCaeTG9TqNU/1ot62B+g1WF3WV2I1D5kguYjrL4Bm3d9GcMkRMYb2s3FyQixg2jpxwD
         A6IA==
X-Gm-Message-State: AOJu0Yw8eoyIABHFCNohqtT+tokjLEATDhhazbeDeDI1+9fq77SlKdQf
	6ALYPmBs/1Zqsm/6NF4RQKLFeaJ+veCK6EQdkcM=
X-Google-Smtp-Source: AGHT+IEKf5FnbRgEi87NDHGprgQgoxo4ulJ1oMt9NB8eglusxgPkKfKH6/eITi+O3K6diUMRGSvjoQ==
X-Received: by 2002:a17:906:c107:b0:9a2:295a:9bbc with SMTP id do7-20020a170906c10700b009a2295a9bbcmr1501736ejc.37.1698992369302;
        Thu, 02 Nov 2023 23:19:29 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z9-20020a1709060ac900b009c751e41ebasm531644ejf.141.2023.11.02.23.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 23:19:29 -0700 (PDT)
Date: Fri, 3 Nov 2023 09:19:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: andersson@kernel.org
Cc: linux-acpi@vger.kernel.org
Subject: [bug report] device property: Add helper to match multiple
 connections
Message-ID: <2bf7d32d-0684-4e4c-a310-b3c3d4a5cb85@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Bjorn Andersson,

The patch 7a20917d30fb: "device property: Add helper to match
multiple connections" from Apr 22, 2022 (linux-next), leads to the
following Smatch static checker warning:

	drivers/base/property.c:1374 fwnode_devcon_matches()
	warn: 'ret' is an error pointer or valid

drivers/base/property.c
    1353 static unsigned int fwnode_devcon_matches(const struct fwnode_handle *fwnode,
    1354                                           const char *con_id, void *data,
    1355                                           devcon_match_fn_t match,
    1356                                           void **matches,
    1357                                           unsigned int matches_len)
    1358 {
    1359         struct fwnode_handle *node;
    1360         unsigned int count = 0;
    1361         unsigned int i;
    1362         void *ret;
    1363 
    1364         for (i = 0; ; i++) {
    1365                 if (matches && count >= matches_len)
    1366                         break;
    1367 
    1368                 node = fwnode_find_reference(fwnode, con_id, i);
    1369                 if (IS_ERR(node))
    1370                         break;
    1371 
    1372                 ret = match(node, NULL, data);

This is hard to analyze.  Smatch is doing something wrong but it still
ends up looking basically like Smatch is right?

According to Smatch on my config these are the match() functions
usb_role_switch_match(), typec_retimer_match(), typec_switch_match()
and typec_mux_match().  They can all return ERR_PTR(-EPROBE_DEFER).

    1373                 fwnode_handle_put(node);
--> 1374                 if (ret) {
    1375                         if (matches)
    1376                                 matches[count] = ret;
                                         ^^^^^^^^^^^^^^^^^^^^^
Do we want to record that here or treat it as an error?

    1377                         count++;
    1378                 }
    1379         }
    1380 
    1381         return count;
    1382 }

regards,
dan carpenter

