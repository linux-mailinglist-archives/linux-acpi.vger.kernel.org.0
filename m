Return-Path: <linux-acpi+bounces-17632-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5308ABBE9B5
	for <lists+linux-acpi@lfdr.de>; Mon, 06 Oct 2025 18:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0963BF2B9
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Oct 2025 16:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8B12D8789;
	Mon,  6 Oct 2025 16:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkIHguyW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7786F2D7DF6
	for <linux-acpi@vger.kernel.org>; Mon,  6 Oct 2025 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759767273; cv=none; b=ZqIFtbU3xeB588e7a2yaXkbAHuPog6jtbjGVvYteeGX6+0f42SJuCNwd3T/TZfhhMEgktU+0XY4SKqxGrT6Zw08TyG7IGp2fyE29g3zsvRU6b6sQphJ2PrFVujrTx9AygI9K3KfFVkk4VqKFShsQzzhfr+Kb9W0+UVq6sEQRCEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759767273; c=relaxed/simple;
	bh=RJo5A81v6RnAIQbnSEGiBdOBuydwB3xWDtIBqPstUVQ=;
	h=Content-Type:From:To:Subject:Message-ID:Date:MIME-Version; b=QDEZIIFyzutLXkCXAK+PgZwg9R+YqM24q0vcJyo/mZD5eRbHTstiy63VflnHFlWFYtKWnYMaa87KMa0JvUGSArG0j2owGz+AZ3y42mZwMvC0sOVMGiP9gTnevylFZvnrKjK7P91juNagmMdTylk1z83te94dVRvHcs+xXjomIis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkIHguyW; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so5174986a91.1
        for <linux-acpi@vger.kernel.org>; Mon, 06 Oct 2025 09:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759767271; x=1760372071; darn=vger.kernel.org;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :reply-to:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RJo5A81v6RnAIQbnSEGiBdOBuydwB3xWDtIBqPstUVQ=;
        b=YkIHguyWnofMFuK7Zy0BMXnjYYOFxorYSDR+bxeD5uelfRAciKqYy9xXfKtz5NjlKZ
         0NmEUXfE+Es4Dp2Ssxpg8tjN6u78z+fgz3c8Mh5UTzWEVpNR0aD5bkFUgy4d7jxp6Ml3
         bPMLX+O5MOeRSfTtQcEVv6PzvFK5ZxemG7qDx9KRPWACev7QkaZAMTqpFAxH6urlmDU2
         eASOo1wdO+WCrKfpJ8rPUR0HMCoQrLf32Ms90zHxJdABDIdne8kHbjmvyWpH8rLCzBWM
         nqEqg3FtsT7SMfI37384FIjZvvSKfvQvGx1yVrr+nn0zaa1GdY9xp3gkm7zKHbpJ0CZY
         8Mrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759767271; x=1760372071;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :reply-to:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJo5A81v6RnAIQbnSEGiBdOBuydwB3xWDtIBqPstUVQ=;
        b=Aym7On+4Zo+JEWmVH57MYA3VwCC1g3YAp8oKul3iq4MMQLTrbrymdCn/srpdYjzgep
         AoljuMRjmeW9qqz0FxdNr2+MDEGjb4wjMbDTqsqtwV9tAtU1YgTcqjHAC0IZlXY2SGAB
         uzThjVBKN+q2cYdCe+IDR1/AUe+OMdgmOMoDVpSK3xw9D+fL1Q5M9Led19RaGpfCT9n6
         14AD6BxaZOn8SX92CNbOl+tKD7f3SniVDMOsnZd79s7p+QtiUvhO4cS9/ka/okDWbVFP
         HFJqOkwq1yiJtGIyg+KJ+PMgjZANiaPgW2XqohzamWY182mKnU6lnUBzPPRuv+RJiX39
         oOFQ==
X-Gm-Message-State: AOJu0YzLb+Yx17sTyQkBaGi0I152KPCcm8Az1wvKSf8HB4XZ3yXbpAnZ
	/DJv+ZgymujcpfvdIJo0slVZ8Pq+iRkbF74fxwU1FXzfxwm1Qq73aSixlTJAouEQ
X-Gm-Gg: ASbGncufX0vFrNIimkec7s958OaVyGXu7TqC5fsMePrBJAYtoOebDqYQsJZgZCTnlYj
	XCkWuF/ulbCq0LHUUkQnpZ8z87qAR06P93z6N1pe1mXPhsECcI8r5d/HQJahp4QUvQOj8l6qt4B
	q/NgbtJ2LwCADie6XfoTnHhOcz1AZ2PY/1XW3hAigC78FIcoMq3D3kHLtqKN9Yc8L8q7EX2mv0x
	A3v3Cu9r8TmF0zX0uc/Z6ynQTI2hZ+wCxQt0CFeja89cy067jB3Df9yOpISU52srACKzExjN9tP
	8wzVWcdREhnTj4bU+1ZMsAZhVWBoloS8wmBBK3fXlzzqHgETZXkTDF8dQeMljKoy9EajyJDh8sB
	rzswTshNGwUvUYp3AFa4zLTY5f6j1cILLYsqdDkeNMKGU4B7uODNedQ5h1zjgWmPQlg==
X-Google-Smtp-Source: AGHT+IFezVzjOiG+s43KL+BUoeSpnCHhneZlMMNKlwDic3HZeRVTGvHn0H+vOyBd9ALPjjknf3Knaw==
X-Received: by 2002:a17:90b:1a91:b0:332:3515:3049 with SMTP id 98e67ed59e1d1-339c2716dc7mr17335853a91.4.1759767271120;
        Mon, 06 Oct 2025 09:14:31 -0700 (PDT)
Received: from [127.0.0.1] ([154.80.22.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4924c47sm11308472a91.0.2025.10.06.09.14.26
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 09:14:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: Leonel Harvey <leonelharveyces@gmail.com>
To: linux-acpi@vger.kernel.org
Reply-To: chrismorgance@gmail.com
Subject: Project Estimating
Message-ID: <2575bf2f-f841-fd7b-9cf7-35ee9e7584c3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Oct 2025 16:14:25 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Looking for reliable and accurate construction cost estimates for your=
 next project?

We provide detailed estimates using the latest software and=
 techniques, tailored to your specific project goals, scope, and =
requirements.

Contact us today for consultation and pricing information. =
Thanks.

Regards,
Leonel Harvey
Estimation Department
City Estimating, LLC

