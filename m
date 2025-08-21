Return-Path: <linux-acpi+bounces-15886-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A598DB2FA19
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Aug 2025 15:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36BCF189ECA9
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Aug 2025 13:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD773277BC;
	Thu, 21 Aug 2025 13:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IoYpQ4fC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D65032778C;
	Thu, 21 Aug 2025 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782132; cv=none; b=EbcgChNIzrjS6wM3RATZWy1MOA6+DWPbYWh0yEYvZp3De2foof0uRSOBlfU5XGtvSSE+aFMJVw/ibaTvnnSpcokjCMWR+PPe9wl1XEB+G8zhgL8OKtHfptd+0D9VpGKryUBUHUsOkrFCsXc8sLMqpYsopOiiJvJjCQxcrdG3loA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782132; c=relaxed/simple;
	bh=A2ijRMUS+7oRPUD9qva8Kdwgy/8fBCApkL5MxV74WOg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YYh7P3Ed9jEPpvHRTjRj6FwMcNy/oC4N+VGWiyWsOW9pPXOlp+6OGAU2D9PCr47vJaPuwbOYzmKyVICrMayxeWrEy7q2u38RjHBaMc+NGdYq+MxsqLvb0CO3d8dXjIg74HlYI4fkuh68cAByKGPZ+fgUAGgen5opnsaLM/EvuGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IoYpQ4fC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xKq3jx7kl0EOAKqaQSFqNpiB6bLoJPYimZxFkfL6FDs=; b=IoYpQ4fC4XyYcJ/CkWpKYv5xqW
	d/INmxc5clVuthuD9QzLGF4GiBLu2vTa1hiyLFwezOuF3L5rzPKPhJoIjOhmPstqyu+kYsssk+qmE
	ZnLBXRSc8PKGJpKWKk7WVTjL3Q6TApMfX+wpz0Fhkzm9XXrcDjJI/NhYlBDybQLsloZAa5kXwH+8r
	AzTinQrxPr7r9dKt0IHRX74Lpq5UPsTqRe5E77heBQnwdONNklR8heWYKwRwBEPkKPNDijU/zAKMi
	/8I/+vz7RsHW1pdgd5d5GZ1ySWoqKMdRtYh5BAKdDGQP5K8fLw3NvHXH5L3Y8rXNgqF5fHt9WJIWQ
	eJF+S9tg==;
Received: from 54-240-197-225.amazon.com ([54.240.197.225] helo=freeip.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up58E-00000007d3Z-34kJ;
	Thu, 21 Aug 2025 13:15:07 +0000
Message-ID: <6f05a6849fb7b22db35216dcf12bf537f8a43a92.camel@infradead.org>
Subject: Re: [PATCH v3 13/15] x86/cpu/intel: Bound the non-architectural
 constant_tsc model checks
From: David Woodhouse <dwmw2@infradead.org>
To: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org, Dave Hansen
	 <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>, 
 =?ISO-8859-1?Q?J=FCrgen?= Gross
	 <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, xen-devel
	 <xen-devel@lists.xenproject.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>,  Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>,  Kan Liang <kan.liang@linux.intel.com>, Thomas
 Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "H . Peter
 Anvin" <hpa@zytor.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
 <lenb@kernel.org>, Andy Lutomirski <luto@kernel.org>, Viresh Kumar
 <viresh.kumar@linaro.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck
 <linux@roeck-us.net>, Zhang Rui <rui.zhang@intel.com>, Andrew Cooper
 <andrew.cooper3@citrix.com>, David Laight <david.laight.linux@gmail.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,  linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org
Date: Thu, 21 Aug 2025 14:15:05 +0100
In-Reply-To: <20250219184133.816753-14-sohil.mehta@intel.com>
References: <20250219184133.816753-1-sohil.mehta@intel.com>
	 <20250219184133.816753-14-sohil.mehta@intel.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-MQvy9cNew683s0qU1XN2"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-MQvy9cNew683s0qU1XN2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-02-19 at 18:41 +0000, Sohil Mehta wrote:
> X86_FEATURE_CONSTANT_TSC is a Linux-defined, synthesized feature flag.
> It is used across several vendors. Intel CPUs will set the feature when
> the architectural CPUID.80000007.EDX[1] bit is set. There are also some
> Intel CPUs that have the X86_FEATURE_CONSTANT_TSC behavior but don't
> enumerate it with the architectural bit.=C2=A0 Those currently have a mod=
el
> range check.
>=20
> Today, virtually all of the CPUs that have the CPUID bit *also* match
> the "model >=3D 0x0e" check. This is confusing. Instead of an open-ended
> check, pick some models (INTEL_IVYBRIDGE and P4_WILLAMETTE) as the end
> of goofy CPUs that should enumerate the bit but don't.=C2=A0 These models=
 are
> relatively arbitrary but conservative pick for this.
>=20
> This makes it obvious that later CPUs (like Family 18+) no longer need
> to synthesize X86_FEATURE_CONSTANT_TSC.
>=20
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> ---
> v3: Make the non-architectural model checks more explicit.
> =C2=A0=C2=A0=C2=A0 Improve commit message.
>=20
> v2: No change.
> ---
> =C2=A0arch/x86/kernel/cpu/intel.c | 10 ++++++----
> =C2=A01 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index fc68561d9f92..4fbc5465ca67 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -210,10 +210,6 @@ static void early_init_intel(struct cpuinfo_x86 *c)
> =C2=A0{
> =C2=A0	u64 misc_enable;
> =C2=A0
> -	if ((c->x86 =3D=3D 0xf && c->x86_model >=3D 0x03) ||
> -		(c->x86 =3D=3D 0x6 && c->x86_model >=3D 0x0e))
> -		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
> -
> =C2=A0	if (c->x86 >=3D 6 && !cpu_has(c, X86_FEATURE_IA64))
> =C2=A0		c->microcode =3D intel_get_microcode_revision();
> =C2=A0
> @@ -266,10 +262,16 @@ static void early_init_intel(struct cpuinfo_x86 *c)
> =C2=A0	 *
> =C2=A0	 * It is also reliable across cores and sockets. (but not across
> =C2=A0	 * cabinets - we turn it off in that case explicitly.)
> +	 *
> +	 * Use a model-specific check for some older CPUs that have invariant
> +	 * TSC but may not report it architecturally via 8000_0007.
> =C2=A0	 */
> =C2=A0	if (c->x86_power & (1 << 8)) {
> =C2=A0		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
> =C2=A0		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
> +	} else if ((c->x86_vfm >=3D INTEL_P4_PRESCOTT && c->x86_vfm <=3D INTEL_=
P4_WILLAMETTE) ||
> +		=C2=A0=C2=A0 (c->x86_vfm >=3D INTEL_CORE_YONAH=C2=A0 && c->x86_vfm <=
=3D INTEL_IVYBRIDGE)) {
> +		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
> =C2=A0	}
> =C2=A0
> =C2=A0	/* Penwell and Cloverview have the TSC which doesn't sleep on S3 *=
/

Hm. My test host is INTEL_HASWELL_X (0x63f). For reasons which are
unclear to me, QEMU doesn't set bit 8 of 0x80000007 EDX unless I
explicitly append ',+invtsc' to the existing '-cpu host' on its command
line. So now my guest doesn't think it has X86_FEATURE_CONSTANT_TSC.

For reasons I also don't understand, for a Xen (in qemu/kvm) guest this
results in about a four-second delay when bringing up each vCPU.
Timestamps added to QEMU's stdout because the kernel's own timestamps
are lying...

1755781767: [    0.489434] smp: Bringing up secondary CPUs ...
1755781767: [    0.489434] installing Xen timer for CPU 1
1755781767: [    0.489434] smpboot: x86: Booting SMP configuration:
1755781767: [    0.489434] .... node  #0, CPUs:          #1
1755781767: [    0.489434] installing Xen timer for CPU 2
1755781767: [    0.489434]    #2
1755781767: [    0.489434] installing Xen timer for CPU 3
1755781767: [    0.489434]    #3
1755781771: [    0.489434] cpu 1 spinlock event irq 45
1755781775: [    0.544262] cpu 2 spinlock event irq 46
1755781779: [    0.604306] cpu 3 spinlock event irq 47
1755781779: [    0.604792] smp: Brought up 1 node, 4 CPUs
1755781779: [    0.604792] smpboot: Total of 4 processors activated (103411=
8.38 BogoMIPS)




--=-MQvy9cNew683s0qU1XN2
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCD9Aw
ggSOMIIDdqADAgECAhAOmiw0ECVD4cWj5DqVrT9PMA0GCSqGSIb3DQEBCwUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0yNDAxMzAwMDAwMDBaFw0zMTEx
MDkyMzU5NTlaMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYDVQQDExdWZXJv
a2V5IFNlY3VyZSBFbWFpbCBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMjvgLKj
jfhCFqxYyRiW8g3cNFAvltDbK5AzcOaR7yVzVGadr4YcCVxjKrEJOgi7WEOH8rUgCNB5cTD8N/Et
GfZI+LGqSv0YtNa54T9D1AWJy08ZKkWvfGGIXN9UFAPMJ6OLLH/UUEgFa+7KlrEvMUupDFGnnR06
aDJAwtycb8yXtILj+TvfhLFhafxroXrflspavejQkEiHjNjtHnwbZ+o43g0/yxjwnarGI3kgcak7
nnI9/8Lqpq79tLHYwLajotwLiGTB71AGN5xK+tzB+D4eN9lXayrjcszgbOv2ZCgzExQUAIt98mre
8EggKs9mwtEuKAhYBIP/0K6WsoMnQCcCAwEAAaOCAVwwggFYMBIGA1UdEwEB/wQIMAYBAf8CAQAw
HQYDVR0OBBYEFIlICOogTndrhuWByNfhjWSEf/xwMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6en
IZ3zbcgPMA4GA1UdDwEB/wQEAwIBhjAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIweQYI
KwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYB
BQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RD
QS5jcnQwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0
QXNzdXJlZElEUm9vdENBLmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcNAQELBQADggEB
ACiagCqvNVxOfSd0uYfJMiZsOEBXAKIR/kpqRp2YCfrP4Tz7fJogYN4fxNAw7iy/bPZcvpVCfe/H
/CCcp3alXL0I8M/rnEnRlv8ItY4MEF+2T/MkdXI3u1vHy3ua8SxBM8eT9LBQokHZxGUX51cE0kwa
uEOZ+PonVIOnMjuLp29kcNOVnzf8DGKiek+cT51FvGRjV6LbaxXOm2P47/aiaXrDD5O0RF5SiPo6
xD1/ClkCETyyEAE5LRJlXtx288R598koyFcwCSXijeVcRvBB1cNOLEbg7RMSw1AGq14fNe2cH1HG
W7xyduY/ydQt6gv5r21mDOQ5SaZSWC/ZRfLDuEYwggWbMIIEg6ADAgECAhAH5JEPagNRXYDiRPdl
c1vgMA0GCSqGSIb3DQEBCwUAMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYD
VQQDExdWZXJva2V5IFNlY3VyZSBFbWFpbCBHMjAeFw0yNDEyMzAwMDAwMDBaFw0yODAxMDQyMzU5
NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqGSIb3DQEBAQUAA4IC
DwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZeYAS/SRV6zmfXlXaZ
sNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2zkC9S7/yHDYnqegqt
w4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qGpgFdZEk2/c//ZvUN
i12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41vav1RhZJzYan4a1gU0
kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0cvnO8FM6PTqsnSbcc
0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PWPU6zfQTOMZ9uLQRR
ci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXtREF5lLXxp+CJ6KKS
blPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQrlR0gO3lBzuyPPArV
hvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7IqaAovAX0d+f1YjbmC
VsAwjhLmveFjNwIDAQABo4IBsDCCAawwHwYDVR0jBBgwFoAUiUgI6iBOd2uG5YHI1+GNZIR//HAw
HQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3bXcyQGluZnJhZGVh
ZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEBMA4GA1UdDwEB/wQE
AwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwewYDVR0fBHQwcjA3oDWgM4YxaHR0
cDovL2NybDMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDA3oDWgM4YxaHR0
cDovL2NybDQuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDB2BggrBgEFBQcB
AQRqMGgwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBABggrBgEFBQcwAoY0
aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNydDANBgkq
hkiG9w0BAQsFAAOCAQEAQXc4FPiPLRnTDvmOABEzkIumojfZAe5SlnuQoeFUfi+LsWCKiB8Uextv
iBAvboKhLuN6eG/NC6WOzOCppn4mkQxRkOdLNThwMHW0d19jrZFEKtEG/epZ/hw/DdScTuZ2m7im
8ppItAT6GXD3aPhXkXnJpC/zTs85uNSQR64cEcBFjjoQDuSsTeJ5DAWf8EMyhMuD8pcbqx5kRvyt
JPsWBQzv1Dsdv2LDPLNd/JUKhHSgr7nbUr4+aAP2PHTXGcEBh8lTeYea9p4d5k969pe0OHYMV5aL
xERqTagmSetuIwolkAuBCzA9vulg8Y49Nz2zrpUGfKGOD0FMqenYxdJHgDCCBZswggSDoAMCAQIC
EAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQELBQAwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoT
B1Zlcm9rZXkxIDAeBgNVBAMTF1Zlcm9rZXkgU2VjdXJlIEVtYWlsIEcyMB4XDTI0MTIzMDAwMDAw
MFoXDTI4MDEwNDIzNTk1OVowHjEcMBoGA1UEAwwTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBANqWLse95HW2F7FhfH9bugyT/danKmmXrbMnz5GZNAfj
Jl5gBL9JFXrOZ9eVdpmw04Tp6aDxZctFLoEDvSWKi367Q7Sg+ci+fH4KwwfQ8Pi0IpIKx2n5emEg
nbOQL1Lv/IcNiep6Cq3DiyaSpSp/RZf+CAfUNySHS8eWmhLU6jGpSD6hxTpYKye7PmrmvMWwfGEP
WoamAV1kSTb9z/9m9Q2LXa89aKmTxNwnAfD3Ohn9mtU3JukwILRMewn9QRXK7KzM+01h5hkCE4nj
W9q/VGFknNhqfhrWBTSQoE9CSVylASGrjzCgS7XmKy/BaH3/7mOOHQv5g1o3Qj/+cdKnpT0I5Qb1
nRy+c7wUzo9OqydJtxzSP4ZyHA4dELto/a3m/ay1XHcpum1pgTOLgxAfGb/T4dCkwRUstSKLMmpL
g9Y9TrN9BM4xn24tBFFyL5znGG0wQGzOVAM68RBzIQb6Fz758fjsr4yZnPbVsU1+gHEs/puNHrG0
9e1EQXmUtfGn4InoopJuU8p5VGD9S3Ikd4UoBlc7xl5yjtNlQxUeYrRlnUSmdlucCEoTX1n4UmtA
9CuVHSA7eUHO7I88CtWG9bGOU7tLgOZoSEvNqtaL/N7sQbBZK4jZ4Rr/zNTQg1SwYjjLB7u96lDP
sipoCi8BfR35/ViNuYJWwDCOEua94WM3AgMBAAGjggGwMIIBrDAfBgNVHSMEGDAWgBSJSAjqIE53
a4blgcjX4Y1khH/8cDAdBgNVHQ4EFgQUXGIam3Bs59Y60yTmWgfDu6pZQ6cwMAYDVR0RBCkwJ4ET
ZHdtdzJAaW5mcmFkZWFkLm9yZ4EQZGF2aWRAd29vZGhvdS5zZTAUBgNVHSAEDTALMAkGB2eBDAEF
AQEwDgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDB7BgNVHR8E
dDByMDegNaAzhjFodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMDegNaAzhjFodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMHYGCCsGAQUFBwEBBGowaDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEAGCCsGAQUFBzAChjRodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVt
YWlsRzIuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQBBdzgU+I8tGdMO+Y4AETOQi6aiN9kB7lKWe5Ch
4VR+L4uxYIqIHxR7G2+IEC9ugqEu43p4b80LpY7M4KmmfiaRDFGQ50s1OHAwdbR3X2OtkUQq0Qb9
6ln+HD8N1JxO5nabuKbymki0BPoZcPdo+FeRecmkL/NOzzm41JBHrhwRwEWOOhAO5KxN4nkMBZ/w
QzKEy4PylxurHmRG/K0k+xYFDO/UOx2/YsM8s138lQqEdKCvudtSvj5oA/Y8dNcZwQGHyVN5h5r2
nh3mT3r2l7Q4dgxXlovERGpNqCZJ624jCiWQC4ELMD2+6WDxjj03PbOulQZ8oY4PQUyp6djF0keA
MYIDuzCCA7cCAQEwVTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMX
VmVyb2tleSBTZWN1cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJYIZIAWUDBAIBBQCg
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDgyMTEzMTUw
NVowLwYJKoZIhvcNAQkEMSIEIDmYXiAIqUEHepr3ZS6jHoNY2RgPdPAf/DeD8UPej8GSMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAhWAYCoC0NlJL
tpjjr7JqJPaupLD1vFsw4dGzKIehcImdKQxzJiZ3QOXW2ZH/+e2OCTy9dVsZ23NCbRk8X3LREH8u
K3Vh4qFfjfdsTH43v9fmImwQhHzD/5rFeYV9sx/eZmAFci5vXxDoKV8ueEWqKpjevYsqIU/8UVvU
ce3klqrKKOVsTOJ0MtQmH1W1Dn0OJp5spoqveo9WYobAQ5PydSk98DHrODA2cRRY0772Zi8NITof
J7B4wCPypKXQ7ljk8Eyw1o6w7PVNyNw8C2NagBdkEcIq2HnNnPRzT3q8T/uyuMmpDHvs4LbvaooC
JhvDqKIOGjyr/iE4u3RvNL0qUt5CTWOE4pu2DQjrWCnVTP/wXa4eHadSCffpZCuQhH6ZdIawY1/g
uivHV4cnaY9KeK8x0D1iXlb/suWWQKPZyLfzx8zmuXiRAuS7jrrycZ6pL4agaARBsaW1xxPEeQ11
KFLKelQjojrVQHWuiWlfY8XJlZhG7Der4BycE3Y1l4D1UNKr5iWywURvQpQEDvghnYWL5NNvMHpt
AjU988ArpfSe8GrE1cEyDOtpLOX07qeaSmrSQW2kwQ7P2uWsYjjwXFPDi6EZ8Awf9qtdlyTbe7hQ
nzBau6iXOUt7Nl4lZki9b9LdR9L7W7baColrB/e23E4QXF6QgHceEvo4FF1p3akAAAAAAAA=


--=-MQvy9cNew683s0qU1XN2--

