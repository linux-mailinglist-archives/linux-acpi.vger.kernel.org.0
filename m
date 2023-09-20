Return-Path: <linux-acpi+bounces-3-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA90A7A8BCE
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Sep 2023 20:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49CA6B209BD
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Sep 2023 18:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9283450C6
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Sep 2023 18:32:44 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F13D79EE
	for <linux-acpi@vger.kernel.org>; Wed, 20 Sep 2023 16:35:29 +0000 (UTC)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA8CD3
	for <linux-acpi@vger.kernel.org>; Wed, 20 Sep 2023 09:35:27 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-65649c60858so24210676d6.3
        for <linux-acpi@vger.kernel.org>; Wed, 20 Sep 2023 09:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695227726; x=1695832526; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i6XY8wIMD7LjGNpegRcCUKrZA0w1gq5GxQRY7mj2AIc=;
        b=CEPJOc5cualblGrX5y9SaUm1krIYndzfuiGDL049Na3LH7mz6kNwYM1eIUPmoVnULA
         /Zoya0M3lL5UV6C21egbRBeJfSbsZRJ7aOVmsTwYdEHRoZu9VL8+rwa8r/pbJlTtkkBF
         olg+aiPbqzYpgVM37O01w6sGI3dXZep2drADM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695227726; x=1695832526;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i6XY8wIMD7LjGNpegRcCUKrZA0w1gq5GxQRY7mj2AIc=;
        b=WQkz+w0OefHOeR0e6k70Klcw5KkF9p3d6IjcIxMnLqn3M5MV4szrTSHP0+HUoAFTwJ
         5O5G5r/NK4lBsHcvXWiqu6rfV724ETAH0nzN2DryZEXiaSjvcKbFhsMOKvy49qzlx3tx
         BmD6tTlFzpHxOnMMdA6VAMlb3Yc+MHKLbkOfdvhAXVzSPnnkkGk1p4FYPJDwrUO6PPQ8
         gwF5nOTPSouMxuigNqBt4YdVUAzKGjDfc7U71bPdnvXxIHqOdfxSMU/jyP1rPSfxJ7vg
         yN69OOEMCWEoPIU1GpT4mPhylj3cy2WrLPpOn+MKhhcJPL8spfxDdelmNT2aQMyG1WsZ
         OwXg==
X-Gm-Message-State: AOJu0Yw5gZGpU2cQUQcR8rx5dEzSjoz2Sa87cfsgrm737L+hFTs+dXQf
	qfUO+V0JlbQIyTWqY7LwmRkdMZ+51LKija4yPQU=
X-Google-Smtp-Source: AGHT+IHLcaN6fMVEmuuixNmbujbqx8ZZX/d8HDkdRqF9ekLc7DepQ87nnQwLoqwwp1wMqCKvYmsVcQ==
X-Received: by 2002:a0c:dc84:0:b0:656:3f74:45ea with SMTP id n4-20020a0cdc84000000b006563f7445eamr3029646qvk.22.1695227726578;
        Wed, 20 Sep 2023 09:35:26 -0700 (PDT)
Received: from meerkat.local ([209.226.106.110])
        by smtp.gmail.com with ESMTPSA id x8-20020a0ce0c8000000b0064733ac9a9dsm4623436qvk.122.2023.09.20.09.35.25
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 09:35:26 -0700 (PDT)
Date: Wed, 20 Sep 2023 12:35:17 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: linux-acpi@vger.kernel.org
Subject: This list is being migrated to the new infrastructure
Message-ID: <20230920-dweeb-trowel-49c3bc@meerkat>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello, all:

This list is being migrated to the new vger infrastructure. This should be a
fully transparent process and you don't need to change anything about how you
participate with the list or how you receive mail.

There will be a brief 20-minute delay with archives on lore.kernel.org. I will
follow up once the archive migration has been completed.

Best regards,
Konstantin

