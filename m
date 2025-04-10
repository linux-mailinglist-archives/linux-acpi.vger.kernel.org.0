Return-Path: <linux-acpi+bounces-12949-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EC3A84A7E
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 18:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4359A1D93
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 16:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C136E1EEA56;
	Thu, 10 Apr 2025 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="AiHIN+8C"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1951EFFAD;
	Thu, 10 Apr 2025 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744304111; cv=none; b=TbqN4H6Ck9j4pHgmFW6LnBdpz+hLlrr3/40y2sKjUrc5pVRcmG6F/C54hCac+nQ53znZKjIRIP75ocoxPKZbbBBCA3bjjfzU2KtnVxUuePeFLvdVc7X6JxZqx2BYAEJkmMaRBuY0cBQFth0Yge/te3Zuv3gyQGnhr3kY5ktaahE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744304111; c=relaxed/simple;
	bh=jr7IvKeCXX2HCm0pjy23wiCb6QGdEzIViDoHGwXVNK0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rciKmi1YMt82Lc2RHcVr5EUt0A3h4iMA1SMnh8FhQg35y+Se4CPsiOh5xFhgJT9JlU+d0JxfjVy6KhvCssBOsGpINikhPj15qUhCcVwgv7qP/Gpi9u0PESMD74kKzVEFWaKXwEaSZtv5Ofr3krDXSVUHDdrdVFBR9RoDd5z4ZvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=AiHIN+8C; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1744304107; x=1744908907; i=w_armin@gmx.de;
	bh=E5IEqst5QifiNmEPxnMLO7fV0b71J9ICRr3urOpzNUY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AiHIN+8CQEK7bQK7ReJH5JbtEtg6EpdT8CUFJWJj5uoMKerF84zKa32AtDRyKIr+
	 7aUwYpXPDG6VLIvVduAfy9onzWouD1aWhksyYLtD3R0s3uWL7mraWCshOcSBc8rrE
	 Y8zIEikYP1Koq5FIVkCZOkpYlvGLYNWEuX8BIAO45HBVSB6QHMfqZMIMSXCGJs3TL
	 KhuDCGchG+CZf3xzW/Jv1bVqkmN2QwQTLevqzDDFImVlKODti0QBolZvAbAU8EUdp
	 SKYFz5IW0QzdZrzeYmUsMEiTjw2D+vKblkVEI+7jDDpvGc91nGDZXH4WLRq6T/q/v
	 cGYFXFbbIvfQAE6qlw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mnpnm-1tHzVI396w-00p9CE; Thu, 10 Apr 2025 18:55:06 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	rui.zhang@intel.com
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ACPI: thermal: Properly support the _SCP control method
Date: Thu, 10 Apr 2025 18:54:53 +0200
Message-Id: <20250410165456.4173-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QYLUBy5UNdTZv8Wdch5JKS3IJaGVumN3Dp24EqAlX9ai1MZySeu
 fLVO5rPpJ1gDvBwcTRrwC42Vt6GUeaA7qW4giynp1hLNQdO1vjh0ZAaxuBXBnK/4L6nC3ka
 BvCXsfsU3Lolc8nlyQqIvdZsShsz3g4ObkSG+6rmLeXr1p4gp2sR+ON6xCR2zDELYZByfou
 KcEVmanj0sLdzj3Kaqahg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SoTVxWYJg2s=;dy+1h/FxkSP6TYvl7SyDb5dXVGG
 MNQT6KXh402e9pF5UDQrlQHMkjpVSRxtBh7QgxIX7sYKX2tSmzyPxYo07rh+/L13rVwjN2aXj
 Nlyq6417U7uz3C4YvTRSv/ZIAkwOYE6LlYd6ZNq75IwRyY264DAF1nkeTWU0pojJ1Gg7Tmo6C
 RIMZqnh0QeUNuXAAy5vvfCbDQjuaqPCdLGM0hzUX3Lftr0HI4bYbEcMn+ySyYVxHiX5l4liRG
 9uAvJ6GpA/iVaxI5EKuQJwkfMGfMUG5XgTKemzY0UwsLtIbR4OzuS00k+fR3/7j3wTzWDlbb+
 9lAQjs3dpuDE6F0QHfi6bbBgF+YM7rNmSjXs/JzUQzb3aNbxiLM8BbdyRmXqXZJEFfqPcG4dg
 8RjHqiwIlV9isCoGJQ/UGjN0DyRzRJ0gO6jvUat8EMAXrDVqUbrJgMBLgOlXh6B69h4ckWzJU
 asHabi1aB9JXxtLHNqYEwKPz/gyBPYX0hwktE/o9VM9w3NpP+DeW9gzcnHeXO2r/a+jHPhe+3
 o2V/x/VxtK/F1DDYn3XNH4W+spVzyUokZOy/oE1m57nR80ZL5HMXH8JEyyqfG1+yAWhPKrO/o
 2TcU83IYexU25yhZ/YpZlyFftXEKTrah6FKaY00CfX7j9iiNjlLO/5yVBq2CCAwqF6NJkbQzc
 G8BttOtK8kQmgy5LjzECopMjOejjWzjNmiHrjrZrN6kUtxYuAIpf5+F4wFT/uEH6ALEJu2rWe
 vxtcSaYG0qtqbcuHvjsBtdEfLwuVV1f985uoVx0dfIzoDpSd1S4Klz8c0E7GRx1XJxnXfPpue
 nRrOzfniQAdGVNZkkpjfhu0BHVClLkJrsnJe8N5nz/+vD1lFlK2A3t+77lJo3doAwl4psTXqd
 k4Saol5bEthmu7f1VXWQaBqCiWE6rnf6vrRZ2VpuaFH+Koa9Pk4PhaOljJtnJbMDbJf58Dbe5
 aWkJ82M3uZhRzjXjANi5Ww46Uv7H9F7Kl3WiV6A0IvjZW9neIM/oHqBbRxHwnK62lSJBznhmm
 WOyj0vfM6yx/htNTpp51ypnuq8VRVOl1sejpygtQ3U8DhxtkCaxh319GIN46xqCruPBwy27QH
 ddVGuUpON1kP6qm1F0w2b/cfHA1luG6bxu5kgjah/XxsbxMIHcdlipmNezOozSphSb1Hv/XsY
 suKw5ii5N8nt6EcFxbg17XuGouPc/3GyNnHZaBSVXN3AxOs3vzFwZXZEzfT+vtOl0cjJi+g3d
 u7rS6M32Yp/kJ/wa8q/PHjbvCWLH7C6kmfgxXAAxbaEM1+zA6UBhYHsrejMIky6jQgufVCUaT
 RkuUc+JrRC9suV+Mjt6IeZoTA6j3WbxKcIW2ZDcfhNfr0I4LJaRcnOvGqBzsoVs1EAV75oNBQ
 FOULXqkwC/yQEEfn7JQKuLNe9o/nL9gBHhESCe1ram0V5WKOULcT9DHRhkEGdMS0WA18ENTli
 QvlgkImYdl5PQApm3sahDhcejdjDI1SvRCt0GseD7OPviXXH2xzj0EeDUcqayx915gXjbh8rG
 qIjfHNPR4q4woTd9RfKB6jOKCCC2nVsjOLgVDEKnOYiZp/MOIl9YfuoP8l4uEx84Lrq5ekngi
 y5nfzAD3Y1AcSyhHlq1r64Bn5GheqU5mXTHKT89V3YPQeauaY49doYuqhnbSYv2NR1vNYmgzo
 +VDiDhH05LR1zggtvp9PhHfKqQYw09q6zjqDXYzUjXtaCFNx0S451zCohCyhujPByUZPyX+0F
 sc4bciH/nGVwwAQlGe487bsx8EQZp61w+pnEDtw+bPehAXtJQGzvm2JwT92mcSMUG1eVRP4g5
 DwBuL3aQFzDC17hrz6nSaZRvqz8kfuawgOvgxkuCVqKEwvMa1TtiWAdjP5fEsCj9eWN++EytG
 ZhxgHMXtwB+BvtEdtpmczVDBqcvsOcEiLQ9g/cA4ybKxO+uF6EFq/3D20ux2rsjWd6HK59Mij
 n2yUU4XGyvLCGYllcWj5iKQ9UKPkN+Udlm7/QI6NsM66+LSW27Af8KxxX9biAwFp7Z+LKg9Of
 pyX/p5rIIrZpbNgJabDu4uMs0260nccSBVHgtuZzPbeXiAukL1MJOfQX3B58S2Mhi5udAiZ+v
 s9/t68e0s86usbgnPXMCwP5gd7mb1l4ZMojGt6FQ0Wq2qggRSEYv8gyV0eNz519LPqRC5LrJO
 1MJbeipCWV4r5DcN7awj9emvVzVyx95xN+85mtf8DgAx4BMl7/wr5EQvUFmttncm8BLL0Bjk4
 wS1ftOKZpSIUnlCwmb9jCFb5tbG+m09TZRaSSoycMxbUT4z5EQR4FrUsNFW3RKQBc5uJS2HJX
 cFFIzjdAt+e7Yl4BHnqtV46gVPZwbMwIQ0N40mpn+H8T72dgK6nwLPuzTcJv6lOnpIVAmW+47
 0OmE6cx9OozG9Q+RYtfC+yN3zJd5f66lGSy3UbXBh1A3lIHILp/YW72IOoytRjCtnDS1a+e21
 iPAL5FbVAyHad8S3L7MhPfkvoKxGZTjPwfhm+r640Mi4gUf+vS2fhTWwKpKzga8x5uvkDL/XS
 SEwBLR/WZ3MV78Vj49g8Mx8x15pijDY/kcGEhtlHqn02b1XviWWozMxeoE8nSVX5UdsAtGPAf
 CZ9sosQyeWrTdsxi7ggLi2fD8vO9SqRNTwDtb0VN3xpMqOXXwpBnCX7bLcQNXZhiKWdLNM/gg
 eZDFn0k9sswcmXZD24Rk0Gu274J+hd3XwNHBqoY5wW+7uRSIH07ZSi0eGPYidqPRYqO7mCklx
 rHpoFl78My12D9zVn+ItJEP3ZrchWMfWP+Pl6TIn47EbHYtbTKQPigZCY9TCDgmZthLca8yoK
 ojqzCQImKzm9chsH4LicmRczxwj4jqIS2CviDYSq7wavYJoIIzRGmwTMFuXmWOBH2u2BlR1HW
 6qYgbif4GU7mdxio2WM/bp+zY4JVG15BXIXiakGgbMiS83l21Jc2s2qt1Njvz5YJB1uYpItQI
 OF6N+vvAbXYHfyEe7PHcVL96I1V/KVQH8lb2KPFjLwaIlI9JlA+41bUyGj1axDKPNLv5aJ+Ny
 gulLjNrJJq9k/Dnje0drB4=

The ACPI specification defines an interface for the operating system
to change the preferred cooling mode of a given ACPI thermal zone.
This interface takes the form of a special ACPI control method called
_SCP (see section 11.4.13 for details) and is already supported by the
ACPI thermal driver.

However this support as many issues:

 - the kernel advertises support for the "3.0 _SCP Extensions" yet the
   ACPI thermal driver does not support those extensions. This may
   confuse the ACPI firmware.

 - the execution of the _SCP control method happens after the driver
   retrieved the trip point values. This conflicts with the ACPI
   specification:

	"OSPM will automatically evaluate _ACx and _PSV objects after
	 executing _SCP."

 - the cooling mode is hardcoded to active cooling and cannot be
   changed by the user.

Those issues are fixed in this patch series. In the end the user
will be able to tell the ACPI firmware wether he prefers active or
passive cooling. This setting will also be interesting for
applications like TLP (https://linrunner.de/tlp/index.html).

The whole series was tested on various devices supporting the _SCP
control method and on a device without the _SCP control method and
appears to work flawlessly.

Armin Wolf (3):
  ACPI: OSI: Stop advertising support for "3.0 _SCP Extensions"
  ACPI: thermal: Execute _SCP before reading trip points
  ACPI: thermal: Allow userspace applications to change the cooling mode

 .../ABI/testing/sysfs-driver-thermal          |  14 ++
 MAINTAINERS                                   |   1 +
 drivers/acpi/osi.c                            |   1 -
 drivers/acpi/thermal.c                        | 129 ++++++++++++++++--
 4 files changed, 133 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-thermal

=2D-
2.39.5


