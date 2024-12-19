Return-Path: <linux-acpi+bounces-10186-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D349F7425
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 06:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860A9188132B
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 05:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F4B208966;
	Thu, 19 Dec 2024 05:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XpPUpYdi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92435216E0C
	for <linux-acpi@vger.kernel.org>; Thu, 19 Dec 2024 05:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734587129; cv=none; b=llKgOlQxSjSPnYDfIRe2Q2LvLRk8waW+zWA2ZPjrlBLJ7N/Pj/fuygPkeGf4CSsNyd0qP2v94bmx2IKp6iHLH8EFROdwb2wre88I345MjZdd17Iu2OB/EOKFAGky0UZEbu25LjiXzILfHEx/hhlrhA5GVrzYd6+qyI/xipSQ0Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734587129; c=relaxed/simple;
	bh=5ogo2BcOorCe2uYPWX/Qh1VgtplOAykfwoSOrA+hMf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c60EAavnDby46evWQF1pCrteWLIRpGgVnyA0c5ZHJD85Ho+SLoEzrwaoS9Y6xo71iYkCCp0wpIFS9aBdwdeNd10mywTv/6qpqE8itGZiC29mUiS5y8hNo4x2beCH4BLnimT4GDKbX1I3urXrCd1LkfMz30dSCZtxmZyRVO3HHJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XpPUpYdi; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b700c13edaso14394385a.3
        for <linux-acpi@vger.kernel.org>; Wed, 18 Dec 2024 21:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734587126; x=1735191926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Axdapzdr6ZrxmJmudI+0kTN/C19UFFWO9w3XWoh6Q8I=;
        b=XpPUpYdiWsqdjqMqe15BYs4eSwo0M7Q3eH86HAZQu+KPEkZ3WDweRe+8Sd9Ib+xHLP
         0Y3EzI9iDhjQyK798mcjDG1R2GHTvhhXnftiD6Z1R8wkKQdqaox98H+Kh1ibDTOUKQH8
         4btWnuoWa1YsoBsECe4lR/Yl/e0DiMReYL7HhHtl2nBpdAdQd2wRycRwADFQLbu444mP
         ITk7D+dX7llg60uhjf+ENVepa9xyUaoyeZ50NygozqemrTWb2QGg4mprYkq6CTOpP1hw
         mYQ6C8KLdEeD0tNcX9jRHUSxfgN7OFLdDeXTanJQV3Uz91NkMhbqlQD3aHbJAgkhleKR
         IOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734587126; x=1735191926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Axdapzdr6ZrxmJmudI+0kTN/C19UFFWO9w3XWoh6Q8I=;
        b=Q3gBSr52IVFfvDi/bWGdqRX+loM8mbmUZM7X1edYNrxKO0pDn7G6zgRxPobcL7OfTj
         0mLkaTcqW6scwD9LcdZh5D9lRCKaOIcga0X/T7ux7lu+KtAwxUFDABjPeuiBPta4uZw1
         jz0o0gh0ZdiKp4MBC7jDLosfjGswAAuKlzMj3on6yhy36difNK5B8C5V5xhXTldcbYh4
         2CCIGG6PkwzhQaTGXxSay64+X/Q1HQWypgAhAEP9BCSUsPpXWNU1miztSKLC1Cnloeu0
         rnFxf4ekpFqcDg41sfsCUIlaNNG34a73QtvzG2Ujd+7rgFTefUXCyUlkp+pNd7ZHDmXt
         zCFA==
X-Forwarded-Encrypted: i=1; AJvYcCVEsJ1PvVBr69Pg2PZ/XUx5XJ4A/2JlCxvBApeuZXw29Uy0Xlrimk3KlnWw00s0vnWStTJcKlnkVVnY@vger.kernel.org
X-Gm-Message-State: AOJu0YzoTIQiG4cBrsX1izbbSL79YCb0iZzmBP8IW+ND9PWdX+VblUog
	3x3t8ovQdNYnuDbPYG/W1DukTqRN1xb/+V4Y8qqx/4U6VJ2UE+xqs8h/K9mAvtLl9U63Pbsplqn
	nB1iAMnJu7Ijar8yxTEbfE80eixKfP9+CS6e3
X-Gm-Gg: ASbGncuLjZo9iUQIz6430CKm0dwygFNer0Avf9kIjyog8HcgzTdjQQMC69FrAolA/Xl
	xkVuCTC5/xGMMIs7F8BJd7j4yHXoOcQBXemsPW0Q=
X-Google-Smtp-Source: AGHT+IFG8pAtrNtHDLySzLKcFMOEVC6cao+v4eWIY6t5hFiYDzawGScV7o6rPaJAxk+ewsQxJsAZbkps8de8R2C8HaY=
X-Received: by 2002:a05:6214:2aa5:b0:6d1:87f7:2924 with SMTP id
 6a1803df08f44-6dd092750a6mr99678066d6.47.1734587124721; Wed, 18 Dec 2024
 21:45:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216201148.535115-1-briannorris@chromium.org> <20241216201148.535115-4-briannorris@chromium.org>
In-Reply-To: <20241216201148.535115-4-briannorris@chromium.org>
From: David Gow <davidgow@google.com>
Date: Thu, 19 Dec 2024 13:45:13 +0800
X-Gm-Features: AbW1kvY1NZRh-6cGsvJVAptImGsFQcrw3-7HmI0Fq09ar_36BjeBd6YSZlyuPsw
Message-ID: <CABVgOSkL3iCA9j553GM8pX_SZ80Xx+BWGZ_qaL0jHAY69-WMmg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] drivers: base: test: Add ...find_device_by...(...
 NULL) tests
To: Brian Norris <briannorris@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxime Ripard <mripard@kernel.org>, 
	linux-acpi@vger.kernel.org, Rae Moar <rmoar@google.com>, 
	Rob Herring <robh@kernel.org>, linux-kselftest@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000859f340629990929"

--000000000000859f340629990929
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 04:12, Brian Norris <briannorris@chromium.org> wrote:
>
> We recently updated these device_match*() (and therefore, various
> *find_device_by*()) functions to return a consistent 'false' value when
> trying to match a NULL handle. Add tests for this.
>
> This provides regression-testing coverage for the sorts of bugs that
> underly commit 5c8418cf4025 ("PCI/pwrctrl: Unregister platform device
> only if one actually exists").
>
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>

Thanks. This looks good to me.

Reviewed-by: David Gow <davidgow@google.com>


-- David

> Changes in v3:
>  * Fix potential leak in test error case
>  * Add Maxime's Reviewed-by
>
> Changes in v2:
>  * Keep "devm" and "match" tests in separate suites
>
>  drivers/base/test/platform-device-test.c | 41 +++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/test/platform-device-test.c b/drivers/base/test/platform-device-test.c
> index ea05b8785743..6355a2231b74 100644
> --- a/drivers/base/test/platform-device-test.c
> +++ b/drivers/base/test/platform-device-test.c
> @@ -1,8 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> +#include <kunit/platform_device.h>
>  #include <kunit/resource.h>
>
>  #include <linux/device.h>
> +#include <linux/device/bus.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>
>  #define DEVICE_NAME "test"
> @@ -217,7 +220,43 @@ static struct kunit_suite platform_device_devm_test_suite = {
>         .test_cases = platform_device_devm_tests,
>  };
>
> -kunit_test_suite(platform_device_devm_test_suite);
> +static void platform_device_find_by_null_test(struct kunit *test)
> +{
> +       struct platform_device *pdev;
> +       int ret;
> +
> +       pdev = kunit_platform_device_alloc(test, DEVICE_NAME, PLATFORM_DEVID_NONE);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> +
> +       ret = kunit_platform_device_add(test, pdev);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       KUNIT_EXPECT_PTR_EQ(test, of_find_device_by_node(NULL), NULL);
> +
> +       KUNIT_EXPECT_PTR_EQ(test, bus_find_device_by_of_node(&platform_bus_type, NULL), NULL);
> +       KUNIT_EXPECT_PTR_EQ(test, bus_find_device_by_fwnode(&platform_bus_type, NULL), NULL);
> +       KUNIT_EXPECT_PTR_EQ(test, bus_find_device_by_acpi_dev(&platform_bus_type, NULL), NULL);
> +
> +       KUNIT_EXPECT_FALSE(test, device_match_of_node(&pdev->dev, NULL));
> +       KUNIT_EXPECT_FALSE(test, device_match_fwnode(&pdev->dev, NULL));
> +       KUNIT_EXPECT_FALSE(test, device_match_acpi_dev(&pdev->dev, NULL));
> +       KUNIT_EXPECT_FALSE(test, device_match_acpi_handle(&pdev->dev, NULL));
> +}
> +
> +static struct kunit_case platform_device_match_tests[] = {
> +       KUNIT_CASE(platform_device_find_by_null_test),
> +       {}
> +};
> +
> +static struct kunit_suite platform_device_match_test_suite = {
> +       .name = "platform-device-match",
> +       .test_cases = platform_device_match_tests,
> +};
> +
> +kunit_test_suites(
> +       &platform_device_devm_test_suite,
> +       &platform_device_match_test_suite,
> +);
>
>  MODULE_DESCRIPTION("Test module for platform devices");
>  MODULE_AUTHOR("Maxime Ripard <mripard@kernel.org>");
> --
> 2.47.1.613.gc27f4b7a9f-goog
>

--000000000000859f340629990929
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUqgYJKoZIhvcNAQcCoIIUmzCCFJcCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
erg7AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFKFQnbTpSq0q
cOYnlrbegXJIIvA6MFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBR
nRJBmUP+IpudtmSQ/R55Sv0qv8TO9zHTlIdsIf2Gc/zeCi0SamUQkFWb01d7Q+20kcpxNzwV6M7y
hDRk5uuVFvtVxOrmbhflCo0uBpD9vz/symtfJYZLNyvSDi1PIVrwGNpyRrD0W6VQJxzzsBTwsO+S
XWN3+x70+QDf7+zovW7KF0/y8QYD6PIN7Y9LRUXct0HKhatkHmO3w6MSJatnqSvsjffIwpNecUMo
h10c6Etz17b7tbGdxdxLw8njN+UnfoFp3v4irrafB6jkArRfsR5TscZUUKej0ihl7mXEKUBmClkP
ndcbXHFxS6WTkpjvl7Jjja8DdWJSJmdEWUnFjnQnDrqLqvYjeVMS/8IBF57eyT6yEPrMzA+Zd+f5
hnM7HuBSGvVHv+c/rlHVp0S364DBGXj11obl7nKgL9D59QwC5/kNJ1whoKwsATUSepanzALdOTn3
BavXUVE38e4c90il44T1bphqtLfmHZ1T5ZwxjtjzNMKy0Mb9j/jcFxfibCISYbnk661FBe38bhYj
0DhqINx2fw0bwhpfFGADOZDe5DVhI7AIW/kEMHuIgAJ/HPgyn1+tldOPWiFLQbTNNBnfGv9sDPz0
hWV2vSAXq35i+JS06BCkbGfE5ci6zFy4pt8fmqMGKFH/t3ELCTYo116lqUTDcVC8DAWN8E55aDGC
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAZ6Vqszmp/3gGFW0sCFu
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgNYSepKK93PrHwrWN7EGHKi4RUthG
b5rYQ1DfBLlyQaswGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQx
MjE5MDU0NTI2WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAJ3Sk+KTQ0TVrvYxVPitJbYLr9ZvekqUbRmm4haOsW6eHNfs
Wrgb+2eoxRbhwx1qcqgElZ28jh5zk1Tv/hj3QgxWFSkyR4OU5NGjkrF7ZhrV5xZiVY4sQ7DjkzQ1
wmNmP8pZMvWlz+faZAmjEvQsgxKS/Z+FDHCqGXakhtkwg+4yJFkIGw4yQ/4ioft2Z2QrEVN2eTa6
3fU9bbwcTw905F5o9fR3frN12NTYMFAB8mlTKMaFtVV/DhNGiTtLkZzZuIzj0HFairj7yGU6ok1W
59Kjnzb4apVKF7XZw5j/fmXzMfWbSMhgPTZaiIeVCEKJv6ejkcu5WcC1aSWejOkdqO4=
--000000000000859f340629990929--

