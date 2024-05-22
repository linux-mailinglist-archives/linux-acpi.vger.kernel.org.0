Return-Path: <linux-acpi+bounces-5950-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB738CC82E
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 23:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24391C20F96
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 21:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9674D1459E5;
	Wed, 22 May 2024 21:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ZZxz4Z4p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3CF442F;
	Wed, 22 May 2024 21:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716413822; cv=none; b=r+avmcUC2LRNNy8ynPOpZ3fE90tl0JbFSgz47qTp8xaGliXb3oj0PRYCX32XyCLT5mndos0DMhu0RQqUh8Ff2AK5tJ/YR0m1hBCuEBcxABtiBouD4I5/sodwkWJS6zxGLXJRNRD+0nZ5m1svST2/2ROt2WDC0OCCwAt2OY26hag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716413822; c=relaxed/simple;
	bh=B/bfstJr1D26BrJSu7bzyn6j6rpSF3AtWWAFZXs804s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=svcJbbxPfVetnvWh30+YEwCJ9+kS9TdOZOylN7vD7PL7GAY+arT4c/ceJsAX/+ODUhUX0WW1VKjzjxLmLXwMmRX3PBH+/muRG10hWQBJ0wY+iZFAyKmeoKSW1Sd7Zqb5N+hlWBGlNl+u3m7sFWT76lYLRb0v5CpsYKZDkGJcDrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=ZZxz4Z4p; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716413813; x=1717018613; i=w_armin@gmx.de;
	bh=+qZGyBSKRKms8oRgIzNvT2oPRilnHMhSmLVziRMEnJU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZZxz4Z4pg4KxnLE8ppQ/OIz6BSzuygEYzI9uumNwQrXnwT+Jmaqc8IFKU+n16Bqg
	 X3v/qofJz/LJnKLxjHkHstr4qxVMcZi3SXR8M4nbfZdScRPLwAGR7DXaOyRW4+6SK
	 MCEcpf3P/bxlzLBurWCTd/UTC9dJ3pbBE5ciT6uE2bXeruYfyo8qjZKkjZ5rGvKTw
	 NTpDGtH9pM0ZtETY/49GX8a3IL/4LP7uc/1moJavbTZR2MePir2YdSAAwgcOlAiFW
	 aF5qzrzFdjC1UQwZV1VYA3G9c/2f+X7WAGFWN+XcZwl963FygYQX2iblRNdsyRBts
	 UBZWXXMi4Emj8ofHNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N8GMk-1sekJp1wCe-017TPq; Wed, 22 May 2024 23:36:53 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ACPI: EC: Abort address space access upon error
Date: Wed, 22 May 2024 23:36:48 +0200
Message-Id: <20240522213649.2860-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Pf05s5OeKaqGiFxz2tzwR0caLoFhrL14Eg3phLjV/WWUDLIVGjg
 Qm+6AE6XZ57Bn/O/Yxfz0Q0ErXwI+rOKOLlGaUTeA/B7XtQRB6388FX4wjKgfdmbW/AAkUr
 hyoakBt9/gpJqvb/WcS+dKKeK6RL/su0B3fxJhA/6sccKuj9eBNprXanxMMXp7YABpE3L8m
 +QcG6g4vw4NivWafVydrA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wGvHOcVoVow=;xXrCdUGZuv91I14nLlAQifWtP+w
 ZuEdifo5kzPJCMoCiS4eoG1spfsbiUewYx1BHG0ueqwBhgQwaKifBWn7ehpfAz7yglB7IgooY
 vsb0kaQlfioOaOa7ZHtk4Hj0ZE2jVNoTLZEKqOdx8H9GBWwlRC4IBSdncGt1sqytIdUId9UPT
 Fk4S09TIN1dFSAh+K0HK1e7PVNbvUBf91uRrKi/jQhzr72kdwRUbiCYphAFDSICTfg1uL+bRR
 D+7PkF4hTyiqsrBeB9YMZTkRBZDVNMXVZVni70OsU83FGwdx3A4F3iJstppWX7OypD2EbfOqP
 Zpv2j2rMM7fmcphmkiQVUX7HhEVhx2YrzPk6YNP1DLIPkVUxdaLPDX3fXtHLl+bWAyEQG9OWI
 qDOlUcLgUB4ssl1pI9bHmkF/Um+zuThOER+oIWnSewXeXTKfnVT9opRPtxV1fHAYACuEvY9Xv
 +ysiFLnCyYUf3bh3QNqvT+5A7UTAQZyJct35P22ZmDZ1Y4Icyq63vOll9gfMjx+aAE9ZSyZp1
 w/b3j0TnZSMk+C/P7+casGZJuUHw8ZIJ7xFk9oFgqN+Ah4aOBuTjSSjghab1T4wI45SpYePuh
 sNBtvksyPGCtOPiWSWgCuCvDOhbyc2XTr1q1bdxV5EaUq9Bl8EuNJbxc1kTC76RnM6FdFqXva
 MvpAj+Vskn5NXJMmevUFQrPWqZ6IiQVADcQSArwYyhRApV9P7PjI9Cotzkua7EbZDON9l1DMu
 iEaOf1xy4/J7Qn5OOwyi3sGiELukY+7h2NOGvca1WWQpZy0XMUfNkQvPKzAYUWXvJxVyIi97v
 6EUmCMH5C+LOKPPXXZYP/atnCjHwpzEdSr+ovD/BbTbZg=

Then a multi-byte address space access is requested, acpi_ec_read()/
acpi_ec_write() is being called multiple times.

Abort such operations if a single call to acpi_ec_read()/
acpi_ec_write() fails, as the data read from/written to the EC
might be incomplete.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/ec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index e7793ee9e649..a68dce2147a4 100644
=2D-- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1333,10 +1333,13 @@ acpi_ec_space_handler(u32 function, acpi_physical_=
address address,
 	if (ec->busy_polling || bits > 8)
 		acpi_ec_burst_enable(ec);

-	for (i =3D 0; i < bytes; ++i, ++address, ++value)
+	for (i =3D 0; i < bytes; ++i, ++address, ++value) {
 		result =3D (function =3D=3D ACPI_READ) ?
 			acpi_ec_read(ec, address, value) :
 			acpi_ec_write(ec, address, *value);
+		if (result < 0)
+			break;
+	}

 	if (ec->busy_polling || bits > 8)
 		acpi_ec_burst_disable(ec);
=2D-
2.39.2


