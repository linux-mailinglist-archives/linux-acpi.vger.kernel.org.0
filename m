Return-Path: <linux-acpi+bounces-20058-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 793A6D0302E
	for <lists+linux-acpi@lfdr.de>; Thu, 08 Jan 2026 14:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3BF9301AFC3
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jan 2026 13:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1BF2EAB61;
	Thu,  8 Jan 2026 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="cNaxNI6E"
X-Original-To: linux-acpi@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021077.outbound.protection.outlook.com [52.101.95.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71FB1FE45A;
	Thu,  8 Jan 2026 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767878512; cv=fail; b=WV3BmGVHr8rCeJgsJFt7ekdyoge3uc4ubH0XRqN9r1MsoP8WiNWkGHaTHyenKVSoTSXj4qYBfrlfBrfhCyaXuQGdakEXdPfQ7CMoMwJfDDNoGpmZlumTN5mpPOCbM+ZgdWcmTNsqyM3cBcVWycWkJkdsHQZwjqywTCfXNPmzrlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767878512; c=relaxed/simple;
	bh=tKFjZMbSjYJSkcoit1kjAPd1IIQCYzDkbf+n6+582Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hucx/31f0uDNxN5HK1S5/XgHSkI/YJHc/fBek/Jpj6ON0VOX6Bjl95HKhWAdtV6VlDs+Nn1fa/bK3kU6q2nYRLoSFm7jxl/v1ybxr0TL1+Utt3QPOpGVu6ddx5UMBJ29YotL2pVQl97FgCArQH1KmcOSTvQn1WyI60FB98zoZMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=cNaxNI6E; arc=fail smtp.client-ip=52.101.95.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pEyHrDmG5bw/IKeYE4QEsjjlf/Jpl27GoHRKsmdhblQBFJcVfUqDj6v1LHpHv0Z3y1Gl8Yzv/6GKo65Seoltp9mSspadNHpfOLOceJwrBOQewOz5QZtkylVkjxiPWwFCUYW7wtMxceoCcOZMsrWJ7UB88JktS2ZwW0zVzmURpszdR98VVVReICdfWlEhEdSq3EWuCe1iUVVTFf91HVXNMmv6qseTMVepfg9BA8uQblRfMFGJMkQsTLMkqqyN+yaJHJMROx7hRPgI9lyzDmg4b10VseDkwROk0RDlYKExaVfjUmHIrn7D2bH8iZH1aKAxCM9EZkZjcXsuja4c/fesjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlUMxhIA5i/1qPrGmM1ERVLoMhOVDQq2tY0nH8GgeEU=;
 b=XD+JVkZzSGhl0Q1/ZjxsJEkoTv83btuZAhAJaEjvppvSNq/JZxuqDB3vmitS2ETAMgy6KO67keYPEe3+AWv9I3fetbRAHgMXyjwP7q4Si9CC1C/ywqWmmkKOoUmLutnAl2qKi/pS9sgzg2zIHkIgBjNfryGFy11pwHKNSVaXfLOpRpVjx1qZl56quotxpEAY2Otcw6zxtJgQ2blBcHe8E7eW1PZa3WeHJnuHU8sQ0pLKneiAy55Sw3Hv8FeQxb/EeE8vwxITbbwwi5uWoM7wbLQrNOabMD7lVPXF0slsDVOEFlKX1Svlel+dZi95ALYpAwSNOBkCmrcE5IIFBVLwAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlUMxhIA5i/1qPrGmM1ERVLoMhOVDQq2tY0nH8GgeEU=;
 b=cNaxNI6EoJ8Bx1Ph8t3w0W9tTHDxwZYFbOcQ3+uiKi1N1VTtTaHa4sQxUJeDmIr++bJRXjBPuoNaKXCPInYZZCVPrms9c7uKQvC3dIJXwRIE5veM0QJgTlfgacF0wNDNPXX683Ofv31HdePs6KXFg4BkHKvFJc3l4a7LFGkdsVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB6830.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 13:21:43 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 13:21:43 +0000
Date: Thu, 8 Jan 2026 13:21:41 +0000
From: Gary Guo <gary@garyguo.net>
To: Gladyshev Ilya <foxido@foxido.dev>
Cc: "foxido @ foxido . dev-cc= Rafael J. Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg
 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross
 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein
 <tamird@gmail.com>, Armin Wolf <W_Armin@gmx.de>,
 <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 2/3] rust: implement wrapper for acpi_object
Message-ID: <20260108132141.6cce4827.gary@garyguo.net>
In-Reply-To: <05261e88ac8503e2af59d703389d94cc15f4450d.1767818037.git.foxido@foxido.dev>
References: <cover.1767818037.git.foxido@foxido.dev>
	<05261e88ac8503e2af59d703389d94cc15f4450d.1767818037.git.foxido@foxido.dev>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0001.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: 71bd758d-90fa-4538-12d3-08de4eb8ddb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yr+3Yr3xD8QSteAlK3tNgHQ0bC4VarNMnLVXA/bVP4q6wHXqYdfNwzJvpNpF?=
 =?us-ascii?Q?6NdHJ56pMf5DrZ17RIcidSIYIpXctsO5A2/9vg1EnstUKRqqw4AGcy9McH9g?=
 =?us-ascii?Q?ZWhxap+6KAycMaPk1mRqmFWYLBoCvX/BuSBRyIfTS9DYjer+n0HiuLM5F89n?=
 =?us-ascii?Q?vgCpR8/aNIcvTwEdbSXqbCFp03fVVqCf/6CHRJt1pkgu1gb0xeCLCRBPsFBr?=
 =?us-ascii?Q?iauZ0TZbshu1GAaMguaTT9xjjlURXzkCGmvYBcxhy+g/pww00PmJJYo8b7gV?=
 =?us-ascii?Q?njimb+Qrs6ip2Ey2jB4a3jNTmVE/U+zLnm1nrYjHwTfnrjjPoZpMIRFE2K/E?=
 =?us-ascii?Q?+vjlgMjaYTQ+Uy9T04PMJx9a5Gi7Yliuu/DkYOjVID49vrxmXv3Mw1jzNEtJ?=
 =?us-ascii?Q?phJFpaOXG71NDtv1QXoGdLcQELDWl97Otc9F4q4zD7sTnGjgKNG7Iyg17qe2?=
 =?us-ascii?Q?cR0EFJWxuJs5i+EhPq97u3djbUpGLuvAUmFsqQjkzwdk4tu2qPOpyOBbtsgp?=
 =?us-ascii?Q?4nk9Fl76zy5nRE+3darDOAeylQH3WwaEmZQQ5qEDmR3jkXqgX7dXP3s2n/Ay?=
 =?us-ascii?Q?oDAQIWETUaKVUe2dwd19U9wx6+KSeoRMx7kN5822RAgsC54FeqgMEgxM2fMh?=
 =?us-ascii?Q?GtQFcgt+9JFj7yPICFg0RBInLiN3ANKncEXYeSGEPtnq4H0c6bG8RENmkibQ?=
 =?us-ascii?Q?DKrVg7NC6ldfXlyKAcK6ArDpYi5Vnjd0HSan1wSXG9XjddHKD1g3RHkMpIvc?=
 =?us-ascii?Q?H/ze7s6qShYgZQUBhSljhCw9jGhOmDXmumVds6NBzUoskOIWuXXhMVKqeW9/?=
 =?us-ascii?Q?N2adjA4Aw3G3929FHBOVySzEXguPk8EdyHvESMjUfX8UKf8t/JLxtQDJbGld?=
 =?us-ascii?Q?XEfQjtmp0z6ZDm/q3nFaylFEtoY7+u7gmicmlVNgOtnb20qayGbLHAOqTrib?=
 =?us-ascii?Q?DSi2wGVy7GuhmIuDVLkv4QkMzgFQQKfIF1pHjHo9ef/c6LD4sz/d1SJyuRNJ?=
 =?us-ascii?Q?DI/qBGjRsi+WfLM0+ZAy39YbTIVgI9fKaRMKRzHfm1f6lbVaqxfiZ0HgPrvb?=
 =?us-ascii?Q?0bRKDM7u/RfOxiM8VWzRs2VXAz3rWg2WRsqDpHa9MTV+29XJs8hOIV4WEJZZ?=
 =?us-ascii?Q?31j0QlTKgM/xgCKs+/ZYF6NjCvzIAZWkuGT9JwO5A+do+vTpjS4ApOD6eLec?=
 =?us-ascii?Q?zSGP988qgPsl/9ITg0AJRgaKX3EyQ+ngm89uTI9yW6dx7pFfIvVC8Tz9Xp9H?=
 =?us-ascii?Q?d4VBKtIsHrDzcxUA9nMqa6v8j8oRhoRaTq3IPdtUZ7iUHvDJWMes7BNlLnE9?=
 =?us-ascii?Q?EbEUbPiqltO7Be/GMxWx0SJbzAedVWu7S25EjcxXMGn+BzGkqGNILQJJ8UUc?=
 =?us-ascii?Q?D7oLwc+pG9yV4KWTccfXzwW9XIsy1Pqss9eIbTzTSI55qkZT24KUConN+toB?=
 =?us-ascii?Q?hG67Rx7fmq6cwN1Sw0KLPnfEA3bUPfc6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OnhgOzbCXloxPgm5X9tMo789klfF6aAisqolz8T+8TTENLN4hESkhvi+9aFi?=
 =?us-ascii?Q?kF9jSk5bF8ZqP9J10qXAbsqp7eQx9juexoNwEzcdzywGGOs4tbuaeKIhlOBN?=
 =?us-ascii?Q?JLJV2AvnKmD98aCGp3+DqGhG/i6giFYtbzonboRZgHWfbGCavdfmB3qK5hNT?=
 =?us-ascii?Q?XgBtYnzBUCbNsYhCbnGOYFcx3ooiytIYT3EklEr2fLgxAzgHrX2NowIcuquZ?=
 =?us-ascii?Q?YqFw89E2Vs+zgZxjsYJnRbUnvawjqfEp8BNX/Q58T6gEr2E/gGOMvfwNAmRA?=
 =?us-ascii?Q?caAXHZGSNL+gGBbNO0zZaZUYt3HT+kggx+F/yhTaBRq1q0vG/yrSUEQnma5t?=
 =?us-ascii?Q?mUTnVXneg+1XBCn0sy15KrFREWvBLvA92UHzy+87cul2qHflc7MDpMqqmpI2?=
 =?us-ascii?Q?dfiJvyRYbVHYJxj8F+TMwjh5ydTGp4ABVZkYWMtfrRO/fsesYUa6Seq8Eyct?=
 =?us-ascii?Q?txOvtPTcz1WhJn50ARs9CfiDm4AReOP2+Bn6gRzuw+5sIsdTNGPAHxC+z3gQ?=
 =?us-ascii?Q?crAJAvgwsooM+hv/KxPMGnd97IlnRm3O30YgV4CBa7rhO4vSh/lxIgJtVFFe?=
 =?us-ascii?Q?rv2/aPL7thTF1f0ojO+TAIS5TUaAI0qm9Y7fBysB3zlq1FSOBCM+43vaLaQB?=
 =?us-ascii?Q?yEjCFTNgqBGqb6t9kPrr3Wlnj2ODibsA/G9Z0DmBygOWQVFLIrvuWQ3Kx65D?=
 =?us-ascii?Q?+x1FRyL4y4pD+M0ihp4QXmRdR5bJM04ko1yP8tkeL5XwTTa3FM96StB+6adL?=
 =?us-ascii?Q?L2EfgntMVrdqOxE/E1HihYLSvqC3XLtrZLACkUnpt/bCkfOLQ+Wi4wZcfs8m?=
 =?us-ascii?Q?3JkM8rh6rAQpEV52fkfmkLDE2EGyLUkH+qOItT/BtMF6EbpUcihYxf+FdxN4?=
 =?us-ascii?Q?8ZB1SyIBYiiNYFIZf0G1i8M/ThW1KDEPbuvsKfBaNqrUApAoYGcqHQ/+/WPD?=
 =?us-ascii?Q?psOHFok+aMIhm9ohuE9X2hVZwJn+GoKgaeLyw3SBAwsqCHX24nhst3QrTKt7?=
 =?us-ascii?Q?2JCwwdIX0G2VQ1nHiRhQSYmAlw/1EuqqI282ffBn88XYWCr4qyTdMY/KIk08?=
 =?us-ascii?Q?x/iG/NT0gTT5sqvHjA1RiMHQY+0NuLkl9QcoCVRbt0ZKmTJD5QWFn0ZuQQb2?=
 =?us-ascii?Q?J9dcX/vOmOJavKCHgdD6kSsrLueQHcatXkFTo2jOoFEjetDulor+XizhFDeU?=
 =?us-ascii?Q?Z7wWhh4zcJxCDMoyfbD88kj1LBAnTVzyZYAYe6CB//PXssHBqDS6juuaxCL0?=
 =?us-ascii?Q?olCck/hXJeXOvtVLsheBprhMJU4fh9qcir25e3uj2oIWjaQ/tfiuGjvFqXoh?=
 =?us-ascii?Q?qsTJAHdJmr0XVu/ZTGlRTCdFM91jtagf2LQj/AJeardJFMq6gbZ/utCqZM01?=
 =?us-ascii?Q?Rixa1VKn8mBHho5e8YUfvXGGqH63foHbpgSDRHuY4yL+Ztopje62ilzSoQf2?=
 =?us-ascii?Q?tc3HFVsnfZEJqCUxg+Jyj6iPRqFSTQfya5Fc2ASubpNSeBdAGPXxFJjQ3xQI?=
 =?us-ascii?Q?rTYdxf0MaHLIU1okGjYshXyj8Se5MiVoVCjEwzD8/6JnjP/x+Oi3gGfNO6TR?=
 =?us-ascii?Q?5qWy9j10tg0AGbTfVQd84MAHjVfM44ZTGOOsnXkffJkg111jNu3xt5mRR4o8?=
 =?us-ascii?Q?/xIO9oo4xLhcRkcOrxU9O2FAlfMuS6prNygHbJnJIpzkdzGLpEhgb3L582yZ?=
 =?us-ascii?Q?9/DzFs50vkYbBAgSuWXINk9HhJXip/Ya3HIIyUVYodPtrkTg1yjVxySWwHbY?=
 =?us-ascii?Q?h5V+ZAh3mw=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 71bd758d-90fa-4538-12d3-08de4eb8ddb6
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 13:21:43.5089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuHw/tM/OwfoIy8KA3fO0Gips7XaAsv3gOtE9IjbG4Kp+hVhoyisDG3/WKJ6K85orH3CSpVSgJVsocoBpiS1+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6830

On Wed,  7 Jan 2026 23:35:32 +0300
Gladyshev Ilya <foxido@foxido.dev> wrote:

> ACPI Object is represented via union on C-side. On Rust side, this union
> is transparently wrapped for each ACPI Type, with individual methods and
> Defer implementation to represented type (integer, string, buffer, etc).
> 
> Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>


Hi Gladyshev,

I've checked the `acpi_object` implementation on the C side and it appears
that the buffer is not owned by the object (however managed externally,
could either be resting in ACPI tables directly or be allocated).

Therefore, you might want to carry a lifetime to represent the lifetime of
underlying buffers?

> ---
>  rust/kernel/acpi.rs | 91 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
> 
> diff --git a/rust/kernel/acpi.rs b/rust/kernel/acpi.rs
> index 9b8efa623130..ac1a9f305f6c 100644
> --- a/rust/kernel/acpi.rs
> +++ b/rust/kernel/acpi.rs
> @@ -2,6 +2,8 @@
>  
>  //! Advanced Configuration and Power Interface abstractions.
>  
> +use core::ops::Deref;
> +
>  use crate::{
>      bindings,
>      device_id::{RawDeviceId, RawDeviceIdIndex},
> @@ -63,3 +65,92 @@ macro_rules! acpi_device_table {
>          $crate::module_device_table!("acpi", $module_table_name, $table_name);
>      };
>  }
> +
> +/// An ACPI object.
> +///
> +/// This structure represents the Rust abstraction for a C [`struct acpi_object`].
> +/// You probably want to convert it into actual object type (e.g [`AcpiBuffer`]).
> +///
> +/// # Example
> +/// ```
> +/// # use kernel::prelude::*;
> +/// use kernel::acpi::{AcpiObject, AcpiBuffer};
> +///
> +/// fn read_first_acpi_byte(obj: &AcpiObject) -> Result<u8> {
> +///     let buf: &AcpiBuffer = obj.try_into()?;
> +///
> +///     Ok(buf[0])
> +/// }
> +/// ```
> +///
> +/// [`struct acpi_object`]: srctree/include/acpi/actypes.h
> +#[repr(transparent)]
> +pub struct AcpiObject(bindings::acpi_object);
> +
> +impl AcpiObject {
> +    /// Returns object type id (see [`actypes.h`](srctree/include/acpi/actypes.h)).
> +    pub fn type_id(&self) -> u32 {
> +        // SAFETY: `type` field is valid in all union variants.
> +        unsafe { self.0.type_ }
> +    }

This should probably be an enum instead of just integer.

> +}
> +
> +/// Generate wrapper type for AcpiObject subtype.
> +///
> +/// For given subtype implements
> +/// - `#[repr(transparent)]` type wrapper,
> +/// - `TryFrom<&AcpiObject> for &SubType` trait,
> +/// - unsafe from_unchecked() for 'trusted' conversion.
> +macro_rules! acpi_object_subtype {
> +    ($subtype_name:ident <- ($acpi_type:ident, $field_name:ident, $union_type:ty)) => {
> +        /// Wraps `acpi_object` subtype.
> +        #[repr(transparent)]
> +        pub struct $subtype_name($union_type);

Instead of wrapping the bindgen-generated subtypes, I would rather this to
be a transparent wrapper of `acpi_object`, with an invariant that the
specific union field is active.

This way you do not have to name the bindgen-generated names.

> +
> +        impl<'a> TryFrom<&'a AcpiObject> for &'a $subtype_name {
> +            type Error = Error;
> +
> +            fn try_from(value: &'a AcpiObject) -> core::result::Result<Self, Self::Error> {
> +                if (value.type_id() != $subtype_name::ACPI_TYPE) {
> +                    return Err(EINVAL);
> +                }
> +
> +                // SAFETY: Requested cast is valid because we validated type_id
> +                Ok(unsafe { $subtype_name::from_unchecked(&value) })
> +            }
> +        }

It feels like this can be better implemented by having a sealed trait for
all possible ACPI object types?

> +
> +        impl $subtype_name {
> +            /// Int value, representing this ACPI type (see [`acpitypes.h`]).
> +            ///
> +            /// [`acpitypes.h`]: srctree/include/linux/acpitypes.h
> +            pub const ACPI_TYPE: u32 = bindings::$acpi_type;
> +
> +            /// Converts opaque AcpiObject reference into exact ACPI type reference.
> +            ///
> +            /// # Safety
> +            ///
> +            /// - Requested cast should be valid (value.type_id() is `Self::ACPI_TYPE`).
> +            pub unsafe fn from_unchecked(value: &AcpiObject) -> &Self {
> +                // SAFETY:
> +                // - $field_name is currently active union's field due to external safety contract,
> +                // - Transmuting to `repr(transparent)` wrapper is safe.
> +                unsafe {
> +                    ::core::mem::transmute::<&$union_type, &$subtype_name>(&value.0.$field_name)
> +                }
> +            }
> +        }
> +    };
> +}
> +
> +acpi_object_subtype!(AcpiBuffer
> +    <- (ACPI_TYPE_BUFFER, buffer, bindings::acpi_object__bindgen_ty_3));
> +
> +impl Deref for AcpiBuffer {
> +    type Target = [u8];
> +
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: (pointer, length) indeed represents byte slice.
> +        unsafe { ::core::slice::from_raw_parts(self.0.pointer, self.0.length as usize) }
> +    }
> +}


