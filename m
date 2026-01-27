Return-Path: <linux-acpi+bounces-20640-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIziLvpbeGkupgEAu9opvQ
	(envelope-from <linux-acpi+bounces-20640-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 07:32:26 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D289068D
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 07:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6924D300D942
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 06:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1341FDE01;
	Tue, 27 Jan 2026 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="RDJh/djm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419CC1D9346;
	Tue, 27 Jan 2026 06:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769495543; cv=none; b=gtl6W5qNVDg6NvgE5dvZ3YAJYH/fyfoip3yj5FCalYAbxnEeYZRW0Zm8G19Q3tM4N48xb+cp3SonURj6AjoAAB1wF0NJmmSDm14MiqShT/X3XRLy3gqKqdRucZd8kO4/vl4ZE7BogN4vbZVzjhbIBTlok11qeubBN3qBAfvUw/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769495543; c=relaxed/simple;
	bh=CXPNghUgsTSCJX/5zj08XbcrP9j8Xv0TPcoM/1Qs6SU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XJpsEUq2xEhaQBRE8sYjTRYSqdtQsBvvbf1FK8CX4rsyMLs+S/IKq7qb21U1dqjZp3gfXGvW+FJX/eBRbEoXRJflDCBpDXiYAOkCGZiooYQslWf/P0yyLh4PIJpVY9fwpnsjBt/XrNZR8KpEtXxnh7JjZpblcVbmD5dRfc8z5gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=RDJh/djm; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1769495539; x=1770100339; i=w_armin@gmx.de;
	bh=R7DJhzRYfRZ7ugA6OSziYBFZctNfpIBSDOiaaz9bdOQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RDJh/djmxpNtEGbJAfQ/SZKK6y1I68jXB12UdxHOFTWCr8bZ4z00x2tRXzt/Hrrb
	 F5jOfJ2Gt5wgX5lpogj7czifc8N/MA3zdKBipcNVEt18+5Xaigl4fhcPKbP6FvFYn
	 7A7j5RY4edVfX87qNYetpxU8d4mTC4fNlCvDnCAkZCM7lsOSOzUOfTfGO1oCvcIDd
	 ps4TJnytTtY3c8VXiH/FDSYhtGpk/Lg1pcb5faygfdr8Tf9PSTPHsZdzhO9vbG6WF
	 IcDDDo58I+Q3HAw4zM/S/El8w98yxpt+NI1pYsxL7DnI2iBFnZxwhmmmeQUXZI+P5
	 I1eoEu1ZnLzJFRVcnQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MGQnP-1vWbqo07sD-00DV13; Tue, 27 Jan 2026 07:32:19 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ACPI: OSL: Panic when encountering a fatal ACPI error
Date: Tue, 27 Jan 2026 07:32:16 +0100
Message-Id: <20260127063216.240911-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xPhBTiCemMLCY8BVHAAOMfpFsVYJ6sP4worYyaUCnHAwh0IEIWH
 Qh4JoiB8XH3FN/oh5fHkwD1VKbvdVAB9lgTjnYRICKkreK2NlDQ2UXX944+gmJ7XGb0YrS/
 7lvEqILG2rw4OXl7WTFqUM1E/oK7IDBO3KADJ1nYMj2Gk/gXoODnITSImVBO5sV2pLgDDld
 NcPHdF2DnwmPE7ZSE83dw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xY8vAE9Kkk4=;kT3+Sc4t14vJE3rtuo112yZ+O+B
 50ldlHagIUDq0t39kQ6X3cOu60SmSNHvfiKuAmB0PXyHv0zSgoE58ZOUJ1xBMdowWXLAajjIr
 +S3HCkz8u0mIlLDTot015+WTj5yJ5kyBGTx/mIImiZc+lRsNI5FgaGeiDb33VNCfE5hZ0XJli
 jTgSR/wIR8O8rPLi3RyP3ECQIWpe/zOHU8qHeT5mb+rPX4y6J3SVpgC8F3ZGrfcQuA5pEsqme
 cClKH1KhL2RtkSOeS7AC7hiVT41Y1+5f6WZ3syOVGlMQixFB5c4EMZdwSfR0xv/peTmUI9g0F
 bJCkmK7AXEfVeJhzXhGQifrY8CbIezWUaXkpV0s3wS2iU4GSxL7hbNc9/xmrP9jstOgPCCiZ/
 z5NQpULJs8rj3r9xmaRlSkKjNfp6XujN/k4g70YgTYfWtIdnZYM9CPehT94+83jSzOvx2E3Wf
 qL83nMbdcdjcdGkTJAw40vZwOD47kkkkbiNfX8Kw9XHsZWimyooCWT5aoBzkjpqvW8MNGmvMH
 NQHZNfsPVDa0rt/+1p5Ks4SCmMU0sxTXlxmZQ5rVqXb0OpzUCaYy38k5qRBQJWgscXFQH7iuo
 vY8nctG7XFXS11fyPOR++BQjEqU2+nhwQHTxVT1FzzYkhL+MGQhqW5FUQ7iaFqZg0rfmpt3mR
 GdSq/27wo9vLcXK6MrClEsZv9LkUCPZ/f8PKrIK/Leuxkqi2fCnJ4911jxQkxcX2E+AkNUMPf
 +wPh8dUq2PC/f4M/xyF23WOAVITcw6VAd5bz/IH/RpOSv5z4gS38ZADqsVtQ+LpmFtjpdVgf2
 C77nizzSYTSledUKO+N3Y7U4beHrdhu2nHYpDd4L7XtbXZYhyK458PYH0IsXrPHPbJfI+lyH7
 odLtOnP07omIjS5oHuCyWRUp5RAix9YLEPi+FKeNs2OL2mvTXzQ9ODLBCHK4DOVJbkKcvL3NQ
 yILgz6XL42QX45WiFK4StwSGMlDime0IozcDJW+pMthKw1hZMcwxb3WybjxdwdqekC4zsNCzF
 sZzzAtYgzZkIbV3mDv6NX700fyD5h05JlkO/wl7HTIol17Zd9ZJ003NRf+dHEZsPO1Zp7VjiN
 6yDA2HG860WQp1VU+Oub0SB50nw9cXKJiFiTtZdrUEQPUw+STihkvYXdW7knMOYZZOMV7hK7O
 z/Ifn3a6qEHIErJ9a4paNAtxWEdrgNo5wiyca3mExqdYU+iHFlBLirchEocI8+BGaSOPzx4Io
 L4SA5yhMN2XiYu87AfCjnrYShk3p27XwGdDECttjnYIVzFnf8OqS0q/K78t2vO+kMm7XmCOij
 87vWIvKlzH5gPdkiT7tXIIilzxTSCPF96uzvH8OXszCA4mpT4ghE4qJkYqCFDOP4ggKmg1vFQ
 96qoALFGqSq1FldRbpchD4KuZm73T/C4W2N3qnYXK4dYpD/Mnm5N32bElxvrkJtD4WLCcwBOP
 3e0WAHjkro1jwKCf/eVOkJvdUf7yMP1EFOBBeNx0IKxl3ayEtIdOQLBAuRc0XKYkbf8TAcVX8
 Xe27GNEJPty+5dNSClCjf29P/gTFw5G87XaTi6KbmEuqHSgyEQNSKk5ggY4GnoOnEpgknllQ0
 l7iu5x/4N0Y4D1XJX/PXVYptlJQbtL32xg4fhT4WVLfv9QF9prFnlNBdf+gkGHJm8KX1xhTZR
 b9HNQ+dCguD5bOEfmaBmwDpmTZnfliiE5DCGNAauWSl3b/+AAMOTFZ/HLaHSKgAHN5VcYlN05
 gdHYWaG2blcYQU/EOVTzYqEvERj+bMZu8R7ZO0NzwJpni5dyUDBtYwz1iKcUgllL2KCJIEkLR
 QV5bLo9Qrym0X47Nezp1UwYWgsa7F1+Pjsx0DvKUqNdSpOeA3hGmHOFCi/1BBXpt4aGOpl4yb
 IaPiWliNb5swUIljZdMvhqBrsoN/yodJo6WUrH1QxZPnYyb1uNBv+irLERteIYXnclL6s3F2x
 ls1sQgMWeEW7rvNUCP3f1yFKIvi/hKVIDodk5MHQkwudb3YEAbktF3l4cNqi4MbaoDLYPddFb
 7qbu2nvhWryIP7TvOgfxRwQhe+XSa97WzpE34gA+h7M5A71iMtVPUX062BuearemVHlARHI4s
 sS7bHDJbpA928vczTIyzwFq92gQUIYJjFKzXdtG+rHi2whvIT93tDkm6EoG1hxPQgKAk0y4lx
 E6yfUWAVLMg9W0ej+Zjh2skz+/1GjvafO8jxdTlT4TOB2sqUK9y/WbplHD3gRtZgBqeST2PuB
 pFOF6QLfOpC0wAXhfXlR1O8cIV+EhFVkuz8eh3JltkWB0+B/3KARdsNT8RxFSdwwU/A3RTKar
 fBjyK+NbDNh/4VFW7DdlJEvdFfrQAuoV1JzXZZ4uIdmboadPu2aVI7L6RytDWxjplBSvs/Qbn
 m02q3endjnlrC+df6nPrLLfO9rKowUXY1qWg2GuXX6pigxyIznWY0tgNTzcSpqXK2ZdusuOg+
 T4imlrSd1HK3QgAWrUt7A4KgQ0VuQrXtmSoLE3CXovbxWwS/F2ISWIzc+V00E1xzUeFXdhN/7
 21FOYi/UfphXvEb0v8/6ap2tjanpcMNXNWkxiZ0G4gpKDr4Ujnqz52/S/lzRbTZzsjYZgDrzV
 lzkMZPPE1oFMoA/JawP/F8uRBukA0EbQRd3yl0W+lj03SOCgp7aKA9ShZ91/UvkgixogNBQmA
 aU5iVuYMEYNJ/Zp6oTonKSjLRA8OU8Mg3/YUHC8+CV5dOP8Z0X80WikMJD8OnlQouhnlTgQYz
 yHjuvAW8/zYAyEuDpFTfSWu0hhgp6QujLmXVymDv+DY1ehLo2Xn3DonU76eF5IR+T6qWv5SS7
 sODWmspKzRoufXlIPnGIkM4nwFb+RvO7M7P+eRBo8FR4dOV387sc3GCVa+0LK1aB1ocJwB9/Z
 jbZgQzC80Yqg3ZBEqhmEyWtEqEWuNUnjFXvS7PqV3O9BpwWLH49zItgrss/7kuXRjknngcZqr
 ncfWWzSJq39+OtZBGL0zPBTVv1ple6gTxdFWKkGjiLuMcUbm0a8wkwpXX5QrBnWphzNKf3Jd8
 5z/+vi5xB+qU/wBS709uS/ncxokOd6RFc6GuUBw8mSxdIshG+hESfYcXtkLGcneitYGyHu2i+
 O7WflN8BHLUq/DLqHugEMYdqQHWyl6Jq2g2MEneUk4SCfHUVXxuyTf1Yr7KJwB8w9Jswxg6Jo
 9GEYBCm4xtpFOgoYpGpw0+Y7ke9GVa/sUTeddgu8EKhxB/U3eqwQRE6rRCS9hrtMnNGey/IM/
 xT8yfL2jwWnj2rUG7o85CcOaG0bXRJOD5D9Oneol4q5LchbzU3lPgIHwEK9EfM6HcH7Rx3y7B
 SBqiTsLNUF3V1nWzpwfLJ8b2rudXt2QBtslHAHlhUe+q2Ey7EMOinwZqLAzY8LDnC4hcwvDk4
 13hjdQi8FtP+iuQKci0b3FWtfr+R5Q2mUZ7MsZs8e7bZ+lVm3eE7KNM6Hvvb2wTVdWSOzgqA7
 5p0N2edJZrXcQGkQW/ALIN6Jt61GDDssbaG4aWEpeIC5HdBIcgqCcLR59zuoW5tmo36mpm2Kb
 X/300giTlqubDWAXMWyZ8xnzx6djq2SP8rcNRrF0So/NY9BU69enmWq0C40lRhl6ekbrgPh0v
 kuHxVZaSIF+LoF0aSwhjxMY/JHgmzak89Rn4SiY6mXuga8UNUtQNQ6E8Skf1QxXZy/OtfMr2V
 bpW1k53bJlVjRMvgX4Y5x1Rf0UOZUV2R3GKNBX/1+i7r7vYBP6mlxSYs3zqbgtb+YvW3A3/eI
 somHkXypN8LyltfMy6MSikzRxfDV6g02Z2NQumfSsy7WS8q2mIcnZkgbjeTu8m8REIl3Dkq4u
 THhkbT++cEsuMXvWGSTT5GVS3XNIuK2hWJGW7ClsARFl7lFzGpmM2//c6njYdSsqJOOL2X1vB
 dx3CbydHI5OIOO0aBpZaRgAAPBkXhFjlF9DWW7zMU/DCtW1m7HF8dL1mpWMVDCvAUAkQ4uAAC
 Qp+5jw830kWFLpBLEYix7eqCfBRwT1sXWnzNImqdY5P9TFB8HunF9xMOXT9a4trxHQXn+f/n+
 hbv7k/lJR+Ik37OgiCg5MtWeG4JTgW0rSoEmu3rL7mvQfY82RyysQzEsoHoDL5UhKuKAOvggN
 UFwm8Y+iSQ0NIFEus9QOHzUx6T8awXUf94gX8h1PVf0TTH1/C/WfPOqzawQSSSK7zb0ws8abz
 zH2cW0z1n50gZ1oS1r8U0GsmNlYKGciH02Kv5ArOhjt/b/mXUNeRUI0+ra6YMfMgBWnVr/pbB
 oYt6MIayVWqgvRP9bgiJq5lFxIQVp2V89ymWyqIE9LrPz8O4WS0CGU/NBLkX6M5VBIJDw04Aw
 Z9E4Vh0PgZTllhoCG1KLVDSkcSvmyIe4RFwezcqVfO4ld0oyezZ0M5U/gXQRYAESJIHmdjRib
 PGCDjfRaKXG7u0ppOrnJeVrEXqD7fMvHXSFa1coH0iPQaObcHmcuRmTQafyjv3eUUPIfs+I82
 NhpnUTH/8x8Vc+wKFW99mN4wj3CSXN/m6FMCBdLUxNIpscao9EzFXPIxZgYRnItzdpkTeNXEr
 UY7SzOtvqCy50b8WRejxVqb6tvdazeG46cWnNfuE+coVtumYo6bM7qsbhIS6fPlmnNLdtYDU7
 VmuvBiFNH7BqKKJhJFl7q3UkaTwMDJaOFV0f/IuQC1OnHKqmero02s5Irn6ZbS+L4IRKeaU5f
 bt5XEf3r7R4oOIKUYSz/gv5f6f3NDj6CZtBqIFkpdooUgo0Lb+1tBFDGckTH1SiYTedpcDlE6
 DxACFsN7GPA+kFg1hM00eQ3rMRt1QZKkIQz9nF1rTdrqikD7DNYGBGznTrUZIB1e04luBRRPG
 SHmQ2oHmwD7nPQ9apk9u5ApQWxxOtV6w4CYuJLUsqXAGP6W/nmqLruuRObLUIjWccjJ2YZi0m
 xOMZEdMEXNgYz+wa3RfAgg5vPOppVC19SdZmgOxa5t8g+NEuzZb35vTKc/iocA0X2uqbX0kI3
 nJWXDqYJljRpcOf8tWAQLub+iQmxsewVrkQfobeUYClJi32+a8Oa9myQJEBfExtLRoLh4LiBD
 12B7UxUj9vhI6xNJ9HH0CArdeFSfxItXai9umKCe7iiEmvE7R+J8PCGyuv/t/xziSTDVvIv6h
 jxq4WjNcdubPsFK2mKZT7C1bsFcxMCWYzHExZX3bBYKDWYLoFM8Y5eQyaU3g2ByHvex52i2I9
 xOebQKMEAjdaSGrPMek/+8kZcuq34i+qVvNxYNx7eEa7wW7dMS/55g2J6kXsNEbRLJT3ClPFL
 dOYoAPlfdmTqSNMaGYZJ
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20640-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmx.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[W_Armin@gmx.de,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.de:email,gmx.de:dkim,gmx.de:mid,uefi.org:url]
X-Rspamd-Queue-Id: 17D289068D
X-Rspamd-Action: no action

The ACPI spec states that the operating system should respond
to a fatal ACPI error by "performing a controlled OS shutdown in
a timely fashion". Windows complies with this requirement by entering
a BSOD upon executing the "Fatal()" ASL opcode, a implementation
detail that is used by some firmware implementations for signaling
fatal hardware errors.

Comply with the ACPI specification by triggering a kernel panic
when ACPICA signals a fatal ACPI error. Users can still disable
this behavior by using the acpi.panic_on_fatal kernel option to
work around firmware bugs.

Link: https://uefi.org/specs/ACPI/6.6/19_ASL_Reference.html#fatal-fatal-er=
ror-check
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes since v1:
- use IS_ENABLED() for checking the presence of CONFIG_ACPI_PANIC_ON_FATAL
=2D--
 .../admin-guide/kernel-parameters.txt         |  9 +++++++++
 drivers/acpi/Kconfig                          | 11 +++++++++++
 drivers/acpi/osl.c                            | 19 ++++++++++++++++++-
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentati=
on/admin-guide/kernel-parameters.txt
index 1058f2a6d6a8..140bb239857f 100644
=2D-- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -187,6 +187,15 @@ Kernel parameters
 			unusable.  The "log_buf_len" parameter may be useful
 			if you need to capture more output.
=20
+	acpi.panic_on_fatal=3D	[ACPI]
+			{0 | 1}
+			Causes the kernel to panic when the ACPI bytecode signals
+			a fatal error. The default value of this setting can
+			be configured using CONFIG_ACPI_PANIC_ON_FATAL.
+			Overriding this value should only be done for diagnosing
+			ACPI firmware problems, as some firmware implementations
+			use this mechanism to signal fatal hardware errors.
+
 	acpi_enforce_resources=3D	[ACPI]
 			{ strict | lax | no }
 			Check for resource conflicts between native drivers
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index df0ff0764d0d..7139e7d8ac25 100644
=2D-- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -65,6 +65,17 @@ config ACPI_THERMAL_LIB
        depends on THERMAL
        bool
=20
+config ACPI_PANIC_ON_FATAL
+	bool "Panic on fatal ACPI error"
+	default y
+	help
+	  The ACPI bytecode can signal that a fatal error has occurred using the=
 Fatal()
+	  ASL operator, normaly causing a kernel panic. Disabling this option ca=
uses such
+	  a condition to be treated like a ordinary ACPI error.
+
+	  This setting can also be overridden during boot using the acpi.panic_o=
n_fatal
+	  kernel parameter.
+
 config ACPI_DEBUGGER
 	bool "AML debugger interface"
 	select ACPI_DEBUG
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 05393a7315fe..6375db6d22ea 100644
=2D-- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -11,7 +11,9 @@
=20
 #define pr_fmt(fmt) "ACPI: OSL: " fmt
=20
+#include <linux/kconfig.h>
 #include <linux/module.h>
+#include <linux/panic.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
@@ -70,6 +72,10 @@ static bool acpi_os_initialized;
 unsigned int acpi_sci_irq =3D INVALID_ACPI_IRQ;
 bool acpi_permanent_mmap =3D false;
=20
+static bool panic_on_fatal =3D IS_ENABLED(CONFIG_ACPI_PANIC_ON_FATAL);
+module_param(panic_on_fatal, bool, 0);
+MODULE_PARM_DESC(panic_on_fatal, "Trigger a kernel panic when encounterin=
g a fatal ACPI error");
+
 /*
  * This list of permanent mappings is for memory that may be accessed fro=
m
  * interrupt context, where we can't do the ioremap().
@@ -1381,9 +1387,20 @@ acpi_status acpi_os_notify_command_complete(void)
=20
 acpi_status acpi_os_signal(u32 function, void *info)
 {
+	struct acpi_signal_fatal_info *fatal_info;
+
 	switch (function) {
 	case ACPI_SIGNAL_FATAL:
-		pr_err("Fatal opcode executed\n");
+		fatal_info =3D info;
+		if (panic_on_fatal) {
+			panic("Fatal ACPI BIOS error (type 0x%X code 0x%X argument 0x%X)",
+			      fatal_info->type, fatal_info->code, fatal_info->argument);
+		} else {
+			pr_emerg("Fatal ACPI BIOS error (type 0x%X code 0x%X argument 0x%X)\n"=
,
+				 fatal_info->type, fatal_info->code, fatal_info->argument);
+			add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
+		}
+
 		break;
 	case ACPI_SIGNAL_BREAKPOINT:
 		/*
=2D-=20
2.39.5


