Return-Path: <linux-acpi+bounces-12951-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3259A84A82
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 18:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F65D1B63553
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 16:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450F21EFFAD;
	Thu, 10 Apr 2025 16:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="jo/uUxGl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554B81EF377;
	Thu, 10 Apr 2025 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744304123; cv=none; b=EQlvxF6sPn/Mly2yu+sR7oggX+SytFtNHIzJY0EyfwMgL9gwWRjAQspMmi4cBtVuxbIXJmspgBHeEpF/LcpU0ubv0doGYmTIhb1hmaYcuYKYEz8JCaN3F/vGomI6XMWF5DSBtVrq2UztiAHk9/zpFbu1NBL8WbLuUpD2JYBEuhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744304123; c=relaxed/simple;
	bh=xsU3OjZ5S/Y7/wwCLNnCVbvl34RZpnj9Lr4K4nYehI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L9O8LV8bDC1MiwCNOj+9FSxLxhfjhd/T4Hq4jtAfuoKoaaTz9x8ieWZrE0TJxsD5oPeqHPrY6O2QmvFYL0fhzEN0e0NaGknJo1zPMID77XAz0xkiXDCn+ILgh/23nolC2M2WVuFsf/B1gIb6v+IGosedgwRrm4lduwiWEVBEEIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=jo/uUxGl; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1744304110; x=1744908910; i=w_armin@gmx.de;
	bh=hFtvrUbB7pUzP2DPjOAYhU87qTsmV6Q5Nu3Zk4jonQc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jo/uUxGlFrH6G4BIhJPRtuiuL3JV1j9zOamsD3J0bXcBSATS59OHLY7W3/lQJDp1
	 2+WXHMXkOTAPGeYIkSUSUQ+Sk2GejTAOb8+FMMUyOlHBlaorKdX7B6kMQ7era8vpv
	 Vp1oHKPhojhIC8vS9BNruE5iAw4tVgD1VmLGoeSKsDcI6REqmWzW+iGxWsYxcXuOV
	 Ws7FvOnoDv+cXSPCVi05Ks8zOdeENuRegl7QN/w3CvZcl58cPY5hLlb8hhhAejjFx
	 QGjeFgJ3cZA8cdp5tL+oUtJVU93fV4qSFnbYILjUbTdwQdQwY+HJHD4cOGdKQFGdJ
	 8cRj0kw5i90EMZL1kw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N4hvb-1t19RK2pwV-013x46; Thu, 10 Apr 2025 18:55:09 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	rui.zhang@intel.com
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ACPI: OSI: Stop advertising support for "3.0 _SCP Extensions"
Date: Thu, 10 Apr 2025 18:54:54 +0200
Message-Id: <20250410165456.4173-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250410165456.4173-1-W_Armin@gmx.de>
References: <20250410165456.4173-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8k0heseikQh0Zxv21NBAEGdk08f15zhx32AsD6gXflp23Bg5i7K
 1ndoLgvNy1+0idv5ezRRhY6oZnhT6P/eP0SaO/3iIE97QWV11U4q1oxb7eo1MdcRyTvZwLb
 XZwGjrkDf3h/5y1VhbQxUZ8Gu43f/lap6wngailr84Tmkeo+zd5P39JN/VbDEhCn8+o07Kg
 xVUy024PNwzCFGvThGHEQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XIEXK2VH3Fw=;scxhgpL/5qPD+YtQji78+2D83H4
 eWYCr7EBRyH9ZOmWlaRzyhsz6V4fulrC/vTG4q72arKoxvYZ5lCCAghuLWRENsm/5+2+hJ7gn
 hSVVD2L6eEU38PFHh9ofB3/4D2p4snOcZKpjNdkDKgjjy6p6Ap6QRmMZddcBKgaPpQbGWe5ux
 CWo8tSqfh6NeIj4mvMXKUd8SeMkiDIisWNC7iDtsabe9wG0L6u7QDxn2DWRCZJ/FnAx4oJEk+
 +YodtyL4HuIYPIVOcMO3McGAvg4ZJHoMnByNvx9O+QqW/w/bJW+dIcvfPEXJg6tn355oJZfAY
 RT6+PPjZppX0OLxcCgdNz7DJwP7ENpI3/EZDbmRb8iQ0VZI0qPY85UCX8z8k9iVCcVHLrTzC2
 0979xmkbdCLqKoEvdQJrEz39JZfEoxXxjQezadP9DmESmwhI05w5UjCAwRgshtbg/uU+z5H8x
 jwRFgBpd/dFutbGhDuQNNzsfFCdL7e2bQ0zZJPn2aUR50MPYF8WI4RXKxIisZzCdoEgUjTAhw
 hjiEFJrQA6DE721mzX0niveyWIAiBYmu9D+YKigIUnA7JnmYRth8gUWws5SA8Ch8V90r6cYiL
 n7nXcpVtcpQVAZyQ3GR4biH0Zlb/TP0qNPgCMKs+2QwkBK6/AyTPhZHnBdVOZM4ftCU29Wrqe
 vhUzTjs4m6CCKBawX+mifmd+Xwm+nHzpr4kr9dkhLQ1HaLMp0FaLOzW8FK3PEl+eP65B3oQBP
 BhzoPSpetL8KwN3nqSqkiQsZL1BFS3I2YAujZ3lCrWTXCkJMorSNQXy6OTeB7IiGPN6vmlIMc
 9m8+x6ujCPJjpnHX/MrWzl/+rUftndJ094Q4iI6I1dLtpi+UwInheYNn9j5T+lB65oUKpBFGo
 3aq/ZL6LEHlqgVPBOeWTjnDZlN09GX9rS4EdBLW6XVLdXGk09rM1wP5Ax8kh6P3eFDdTJ/e9W
 j9Zr/bHvUs3WJ6E/VLXJDRBeQA/t4xTFJAcdxDqwVtifm7SFQplycAh3+nVaEU8JbI6vFZdoQ
 2s0JKnW9zc5s0pLKdcOHxC0E0N7nIrCCAjpQyt91LFKAxNcVP16eUcBUUFmPhETZ9IXnXWCZe
 QH1b0DoPPN6XxeXXu28Tmesf7wGl4GBX5/uejp7tqOSbe8i6j/2GBMV+QGkJsFDNqDpT9CTPj
 0S6wRDY5u4xfB1kTYinHs+c/DUuOGUvcpxzyzeij3Gn/W2DlRqcdxp859ShlHMzwocX2Dp521
 wQcocHZbBhCKqtPsDwm1BB3ylPddz3OcIFuL4yorOqZgrJNi61yHYgDx2BhtYT0GNSL0PZfYs
 L/I9SNOX7WJGvvmTDL9Lvbt5KGh3zuKXpPNtdR9jslC6TaZfUZraI7A4JRqXGrLbaDsydmw5J
 oehmbV2vnVx0pn4U/2RIZu/PEXEQZH9JAccSTXFsWUZdXKp2wT1Dwqz0wNP5KwpqrACkhrHuy
 n0oh2ywKoBqqKMdupvuekWck4+KZRuJdVpvaMmN4+qcX2+vEK+ecbSXfFzic+logK50oucON2
 Zy08fCnR7BHyocn0c179unCqK3ZY+5hPA5PIFi7hIijavDe8FvEMkRZ4YZD3y4pRf1pTIiwum
 fGMQBypzLmUUd16LVBvLwN7M6a4tVLyXr/MBlJnrwZcwER1Tj7tV6wXQ+qu1iY2FADjNhJJX1
 p7WTCO9aPfE6Fk8GNEinq0IyrTmyqX7VIgdRXo2bO3Vb89toAUU9Q6X15kzFcquwgXKn7TKzT
 oINbJ5XUV7aowC1tqt6HWKMA1WtG1V4MHYUTOb4od9CGJ5c47CcSTyW/D8B45CVxnuVGSMF8/
 k0NEAGi1HNWMdzXWVwlv9am8+6iht099FzRLIN2R+ZzLA38RUfc3c1WbijkiDGXjfSCOJHVYu
 LNpIVgJFeiFC62ybPEPHk9MI5U017ZKb4FkERL7TvBoNdw6GR7hTec6BU+91iEdMH3KRU5wpD
 /qp09/D/SFlqfXDQ6VxDyg5xfkpcPWJtDJIn6dPJpeXN0tAd+EZuNqMBpwJBqFmg4GdYwZG4f
 2UrbFM6JbD79bW2Lhzn6gy6DFbVvWXeq+kU1aNIAjWqfqeKncRicHazkptKjN8Bt0xsF52+LH
 0um1tPCeVnFJcBb0rk27endWwYJHBDSODmb034BGtbXa/uqLPZXUbBRFO9jFhhW6msoktKP5k
 UAKnJtenPfHbYn7iHPTOvRZwsUKI/eNPCoTXEq6cQSjUCS+K1tZ98eU+KKRFqI4/BNy+j9yNz
 Dww6//20FIqrnVOCuxX040Flq2rtF8Fxnb76wWnD6rAbLz98DBcISAomRxgWbEJqxMKXnokRh
 8EtXVcS2GxmAC0aX6Q2xDLOQuHbmMdVI/NWcB1KkbZrrbk649h+YBZkbhaz11jqORcQoNyhSY
 3/d1mMiM34Tk+AuQa/J+cqpC/hO19XixclqcF9B52Tpxlw0AL2hPhObrG7gi5HZW+oshsOYWm
 n+9xqVF0dR/GHcnqXStnEwfulZKWaMpYafDbrf1QU8t5N81Kmbp20YjOvim7kMDA/Jx3gshBK
 GuEtg274jmCI9m+Rdu22TRSCg1jzDE2MIqVppPx+Z52GSqzGROzZVLsDu56gplEkI8rUtUstL
 NJPmyU0UOXT+gnoIyDEKYV1lt7JfSrB/Cjnd+d0V6bjko07u4FxODHF0GQBx5vctzppmDkwi8
 mTcANWCvK7xKTBGYWUpP4P+xHfce0AjPT3kiC4PbUcBJJ4uuIcpjOxu8dLsR/8HiSf0du7Dle
 6VNvhqqGxcGM1bOPK1WUwKPqG7rpSYWiodzKtb3o3jbU1ZUXuKwVmUmOmfwAzq+CXM0a56dfG
 66Z9UanmL5izKI0bwYX0gIiw2POHqJiGypp1gFCUfd3S0Ifs374cTl82H8WPg5rjjUjFKpQvp
 p4C1ibDpL0aVkjJh6GKSUrsziIKNlfjuUiT4dHSjDDMeJsTCNHdruVq9swkX03TCxdzmdtskg
 GANlHYxw95QB7f29spBzMuNAOy6gcrU9Vtj7u1dkApArYhMIViatQHRbsJpl8yJe4TZUqpXWt
 2KWsTSj0ZwMNt8cECEkTT8GlN7ibRKWQKMjM/3FB6kpTJHvVCkRUwmYb9r/zM1DoA==

As specified in section 5.7.2 of the ACPI specification the feature
group string "3.0 _SCP Extensions" implies that the operating system
evaluates the _SCP control method with additional parameters.

However the ACPI thermal driver evaluates the _SCP control method
without those additional parameters, conflicting with the above
feature group string advertised to the firmware thru _OSI.

Stop advertising support for this feature string to avoid confusing
the ACPI firmware.

Fixes: e5f660ebef68 ("ACPI / osi: Collect _OSI handling into one single fi=
le")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/osi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
index df9328c850bd..f2c943b934be 100644
=2D-- a/drivers/acpi/osi.c
+++ b/drivers/acpi/osi.c
@@ -42,7 +42,6 @@ static struct acpi_osi_entry
 osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata =3D {
 	{"Module Device", true},
 	{"Processor Device", true},
-	{"3.0 _SCP Extensions", true},
 	{"Processor Aggregator Device", true},
 };

=2D-
2.39.5


