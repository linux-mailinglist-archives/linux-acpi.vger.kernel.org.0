Return-Path: <linux-acpi+bounces-5801-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F63F8C5B35
	for <lists+linux-acpi@lfdr.de>; Tue, 14 May 2024 20:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FF891C20919
	for <lists+linux-acpi@lfdr.de>; Tue, 14 May 2024 18:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57495180A6E;
	Tue, 14 May 2024 18:39:46 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from isrv.corpit.ru (isrv.corpit.ru [86.62.121.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B80653E15;
	Tue, 14 May 2024 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=86.62.121.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715711986; cv=none; b=IcPNOWCNGLMI66DKNxcml89L6mtGq8uGAIlpS5GxnGZrw9PSZVQg7nvOVmjHRZ2cECGeI0sNamnneeB4GKVpNXjkgeBJkQLDrk0KFWKGuPVAEdcIecd3PZOwg9zBEOPdrVavNxUGoKY88wLjWLoIcgQe+0ZgJyfJpyJFJg6wkvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715711986; c=relaxed/simple;
	bh=anLITrPCo4rgQvxGdlQ3cOuqw6xzzOHCfNpBHf2xIJo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=XU33vZvVzxaAqRpZUo6yuQzUH1bUijurAq888b8m+AFd4d7dAUTg3Qt01olnHdaHxQGkZe8z53C/OwqOIhzjRplX9uYrf8sFlGPAaPTH0E+fNcMFl6BCT6bRNpfVyxg59q+Dnq1iv0mpl02lIZ8GVkcpkVWuSmBaVfxZmcYiRgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru; spf=pass smtp.mailfrom=tls.msk.ru; arc=none smtp.client-ip=86.62.121.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tls.msk.ru
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
	by isrv.corpit.ru (Postfix) with ESMTP id E27D266B7A;
	Tue, 14 May 2024 21:39:47 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
	by tsrv.corpit.ru (Postfix) with ESMTP id 0B7A2CE9F8;
	Tue, 14 May 2024 21:39:36 +0300 (MSK)
Message-ID: <4adcb590-ae9e-47a5-b0b4-8dcccf78fca2@tls.msk.ru>
Date: Tue, 14 May 2024 21:39:35 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel null-ptr deref after hibernation on thinkpad t495s -
 acpi_cpufreq failure
From: Michael Tokarev <mjt@tls.msk.ru>
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
References: <0060cbfc-738a-44a8-8b39-b190fcc5076a@tls.msk.ru>
Content-Language: en-US
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 xsBLBETIiwkBCADh3cFB56BQYPjtMZCfK6PSLR8lw8EB20rsrPeJtd91IoNZlnCjSoxd9Th1
 bLUR8YlpRJ2rjc6O1Bc04VghqUOHgS/tYt8vLjcGWixzdhSLJgPDK3QQZPAvBjMbCt1B6euC
 WuD87Pv5Udlpnzf4aMwxkgfTusx+ynae/o+T5r7tXD+isccbC3SiGhmAPxFyY3zGcFk4+Rxc
 0tP8YY2FWE/baHu+lBDTUN79efWAkHhex1XzVZsV7ZD16rzDbXFK5m6ApvGJWlr5YDEEydTF
 WwmvwBfr4OINVxzEG/ujNiG4fpMf2NsnFGyB9aSbFjXZevB4qWkduYYW+xpK1EryszHtAAYp
 zSBNaWNoYWVsIFRva2FyZXYgPG1qdEB0bHMubXNrLnJ1PsLAlgQTAQoAQAIbAwYLCQgHAwIE
 FQIIAwQWAgMBAh4BAheAAhkBFiEEbuGV0Yhuj/uBDUMkRXzgoIBEZcUFAmBbcjwFCS5e6jMA
 CgkQRXzgoIBEZcUTIQgA1hPsOF82pXxbcJXBMc4zB9OQu4AlnZvERoGyw7I2222QzaN3RFuj
 Fia//mapXzpIQNF08l/AA6cx+CKPeGnXwyZfF9fLa4RfifmdNKME8C00XlqnoJDZBGzq8yMy
 LAKDxl9OQWFcDwDxV+irg5U3fbtNVhvV0kLbS2TyQ0aU5w60ERS2NcyDWplOo7AOzZWChcA4
 UFf78oVdZdCW8YDtU0uQFhA9moNnrePy1HSFqduxnlFHEI+fDj/TiOm2ci48b8SBBJOIJFjl
 SBgH8+SfT9ZqkzhN9vh3YJ49831NwASVm0x1rDHcIwWD32VFZViZ3NjehogRNH9br0PSUYOC
 3s7ATQRX2BjLAQgAnak3m0imYOkv2tO/olULFa686tlwuvl5kL0NWCdGQeXv2uMxy36szcrh
 K1uYhpiQv4r2qNd8BJtYlnYIK16N8GBdkplaDIHcBMbU4t+6bQzEIJIaWoq1hzakmHHngE2a
 pNMnUf/01GFvCRPlv3imkujE/5ILbagjtdyJaHF0wGOSlTnNT4W8j+zPJ/XK0I5EVQwtbmoc
 GY62LKxxz2pID6sPZV4zQVY4JdUQaFvOz1emnBxakkt0cq3Qnnqso1tjiy7vyH9CAwPR/48W
 fpK6dew4Fk+STYtBeixOTfSUS8qRS/wfpUeNa5RnEdTtFQ9IcjpQ/nPrvJJsu9FqwlpjMwAR
 AQABwsBlBBgBCAAPBQJX2BjLAhsMBQkSzAMAAAoJEEV84KCARGXFUKcH/jqKETECkbyPktdP
 cWVqw2ZIsmGxMkIdnZTbPwhORseGXMHadQODayhU9GWfCDdSPkWDWzMamD+qStfl9MhlVT60
 HTbo6wu1W/ogUS70qQPTY9IfsvAj6f8TlSlK0eLMa3s2UxL2oe5FkNs2CnVeRlr4Yqvp/ZQV
 6LXtew4GPRrmplUT/Cre9QIUqR4pxYCQaMoOXQQw3Y0csBwoDYUQujn3slbDJRIweHoppBzT
 rM6ZG5ldWQN3n3d71pVuv80guylX8+TSB8Mvkqwb5I36/NAFKl0CbGbTuQli7SmNiTAKilXc
 Y5Uh9PIrmixt0JrmGVRzke6+11mTjVlio/J5dCM=
In-Reply-To: <0060cbfc-738a-44a8-8b39-b190fcc5076a@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

14.05.2024 13:10, Michael Tokarev wrote:

> So it looks like hibernate/resume cycle changes something in ACPI and makes acpi_cpufreq
> module confused - either when it's already loaded (happens at resume), or when it gets
> loaded for the first time *after* the resume.  I think some ACPI table dump (before-after)
> might be needed here, which one?
I checked the ACPI tables.  And indeed, after regular platform-based hibernate-resume cycle,
some of them changes.  For one, SSDT5 (which includes \_PR.C003._PPC method) becomes basically
garbled.  iasl does not recognize it.

Before hibernate:
  * Original Table Header:
  *     Signature        "SSDT"
  *     Length           0x0000119C (4508)
  *     Revision         0x01
  *     Checksum         0x5A
  *     OEM ID           "LENOVO"
  *     OEM Table ID     "TP-R13  "
  *     OEM Revision     0x00000001 (1)
  *     Compiler ID      "AMD "
  *     Compiler Version 0x00000001 (1)

After hibernate:

[000h 0000   4]                    Signature : "CRAT"
[004h 0004   4]                 Table Length : 00000810
[008h 0008   1]                     Revision : 01
[009h 0009   1]                     Checksum : 5F
[00Ah 0010   6]                       Oem ID : "LENOVO"
[010h 0016   8]                 Oem Table ID : "TP-R13  "
[018h 0024   4]                 Oem Revision : 000011E0
[01Ch 0028   4]              Asl Compiler ID : "PTEC"
[020h 0032   4]        Asl Compiler Revision : 00000002

**** Unknown ACPI table signature [CRAT]

No doubt acpi_cpufreq will be confused by this garbage.

Can something be said from here?

(windows10 does hibernate/resume just fine, - but setting acpi_osi="Windows 2022"
does not change anything).

Thanks,

/mjt
-- 
GPG Key transition (from rsa2048 to rsa4096) since 2024-04-24.
New key: rsa4096/61AD3D98ECDF2C8E  9D8B E14E 3F2A 9DD7 9199  28F1 61AD 3D98 ECDF 2C8E
Old key: rsa2048/457CE0A0804465C5  6EE1 95D1 886E 8FFB 810D  4324 457C E0A0 8044 65C5
Transition statement: http://www.corpit.ru/mjt/gpg-transition-2024.txt


